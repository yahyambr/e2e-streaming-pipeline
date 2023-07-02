resource "aws_cloudwatch_log_group" "lambda_transformer_log_group" {
  name = "/aws/lambda/${var.lambda_transformer_function_name}"
  retention_in_days = var.log_group_retention_days
  tags = {
    project = var.project_tag
  }
}

resource "aws_cloudwatch_log_group" "lambda_extractor_log_group" {
  name = "/aws/lambda/${var.lambda_extractor_function_name}"
  retention_in_days = var.log_group_retention_days
  tags = {
    project = var.project_tag
  }
}

resource "aws_cloudwatch_log_group" "firehose_log_group" {
  name = "/aws/kinesisfirehose/${var.delivery_stream_name}"
  retention_in_days = var.log_group_retention_days
  tags = {
    project = var.project_tag
  }
}