# IAM Role/Policy

resource "aws_iam_role" "lambda_extractor_role" {
  name = var.lambda_extractor_role
  assume_role_policy = data.aws_iam_policy_document.lambda_extractor_assume_role_policy.json
  inline_policy {
    name = var.lambda_extractor_role_inline_policy
    policy = data.aws_iam_policy_document.lambda_extractor_role_inline_policy.json
  }
  tags = {
    project = var.project_tag
  }
}

data "aws_iam_policy_document" "lambda_extractor_assume_role_policy" {
  statement {
    actions = ["sts:AssumeRole"]
    principals {
      type        = "Service"
      identifiers = ["lambda.amazonaws.com"]
    }
  }
}

data "aws_iam_policy_document" "lambda_extractor_role_inline_policy" {
  statement {
    actions = ["firehose:PutRecord"]
    resources = [var.fihrehose_delivery_stream_arn]
  }
  statement {
    actions = ["logs:PutLogEvents", "logs:CreateLogStream"]
    resources = ["${var.lambda_extractor_log_group_arn}:*"]
  }
}

resource "aws_iam_role" "scheduler_extractor_role" {
  name = var.scheduler_name
  assume_role_policy = data.aws_iam_policy_document.scheduler_assume_role_policy.json
  inline_policy {
    name = var.scheduler_role_inline_policy
    policy = data.aws_iam_policy_document.scheduler_role_inline_policy.json
  }
  tags = {
    project = var.project_tag
  }
}

data "aws_iam_policy_document" "scheduler_assume_role_policy" {
  statement {
    actions = ["sts:AssumeRole"]
    principals {
      type        = "Service"
      identifiers = ["scheduler.amazonaws.com"]
    }
  }
}

data "aws_iam_policy_document" "scheduler_role_inline_policy" {
  statement {
    actions = ["lambda:InvokeFunction"]
    resources = [aws_lambda_function.lambda_extractor_function.arn]
  }
}

# lambda_extractor
data "archive_file" "lambda_extractor" {
  type        = var.lambda_extractor_archive_type
  source_file = var.lambda_extractor_source_file
  output_path = var.lambda_extractor_output_path
}

resource "aws_lambda_function" "lambda_extractor_function" {
  function_name = var.lambda_extractor_function_name
  filename = var.lambda_extractor_filename
  role = aws_iam_role.lambda_extractor_role.arn
  handler = var.lambda_extractor_handler_name
  runtime = var.runtime
  source_code_hash = data.archive_file.lambda_extractor.output_base64sha256
  tags = {
    project = var.project_tag
  }
}

# EventBridger Scheduler
resource "aws_scheduler_schedule" "eventbridge_scheduler" {
  name       = var.scheduler_name

  flexible_time_window {
    mode = var.flexible_time
  }

  schedule_expression = var.schedule_expression

  target {
    arn      = aws_lambda_function.lambda_extractor_function.arn
    role_arn = aws_iam_role.scheduler_extractor_role.arn
  }

}