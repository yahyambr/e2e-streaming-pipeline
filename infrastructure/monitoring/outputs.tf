output "lambda_transformer_log_group_arn" {
  value = aws_cloudwatch_log_group.lambda_transformer_log_group.arn
}

output "lambda_extractor_log_group_arn" {
  value = aws_cloudwatch_log_group.lambda_extractor_log_group.arn
}

output "firehose_log_group_arn" {
  value = aws_cloudwatch_log_group.firehose_log_group.arn
}

