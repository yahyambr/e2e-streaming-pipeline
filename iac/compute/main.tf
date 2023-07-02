# IAM Role/Policy

resource "aws_iam_role" "lambda_transformer_role" {
  name = var.lambda_transformer_role
  assume_role_policy = data.aws_iam_policy_document.lambda_transformer_assume_role_policy.json
  inline_policy {
    name = var.lambda_transformer_role_inline_policy
    policy = data.aws_iam_policy_document.lambda_transformer_role_inline_policy.json
  }
  tags = {
    project = var.project_tag
  }
}

data "aws_iam_policy_document" "lambda_transformer_assume_role_policy" {
  statement {
    actions = ["sts:AssumeRole"]
    principals {
      type        = "Service"
      identifiers = ["lambda.amazonaws.com"]
    }
  }
}

data "aws_iam_policy_document" "lambda_transformer_role_inline_policy" {
  statement {
    actions   = ["s3:GetObject", "s3:ListBucket"]
    resources = [var.delivery_bucket_arn, "${var.delivery_bucket_arn}/*"]
  }
  statement {
    actions = ["dynamodb:PutItem"]
    resources = [var.dynamodb_table_arn]
  }
  statement {
    actions = ["logs:PutLogEvents", "logs:CreateLogStream"]
    resources = ["${var.lambda_transformer_log_group_arn}:*"]
  }
}

# lambda_transformer
data "archive_file" "lambda_transformer" {
  type        = var.lambda_transformer_archive_type
  source_file = var.lambda_transformer_source_file
  output_path = var.lambda_transformer_output_path
}

resource "aws_lambda_function" "lambda_transformer_function" {
  function_name = var.lambda_transformer_function_name
  filename = var.lambda_transformer_filename
  role = aws_iam_role.lambda_transformer_role.arn
  handler = var.lambda_transformer_handler_name
  runtime = var.runtime
  source_code_hash = data.archive_file.lambda_transformer.output_base64sha256
  layers = var.lambda_transformer_layers
  tags = {
    project = var.project_tag
  }
}

# S3 Event lambda_transformer Trigger
resource "aws_lambda_permission" "s3_lambda_transformer_invoke" {
  statement_id  = "AllowExecutionFromS3Bucket"
  action        = "lambda:InvokeFunction"
  function_name = aws_lambda_function.lambda_transformer_function.function_name
  principal     = "s3.amazonaws.com"
  source_arn    = var.delivery_bucket_arn
  
}

resource "aws_s3_bucket_notification" "event_lambda_transformer_trigger" {
  bucket = var.delivery_bucket_id
  lambda_function {
    lambda_function_arn = aws_lambda_function.lambda_transformer_function.arn
    events = ["s3:ObjectCreated:Put"]
  }
}