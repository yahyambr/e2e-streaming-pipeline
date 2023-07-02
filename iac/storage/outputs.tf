output "delivery_bucket_name" {
  value = aws_s3_bucket.delivery_bucket_raw_data.bucket
}

output "delivery_bucket_id" {
  value = aws_s3_bucket.delivery_bucket_raw_data.id
}

output "delivery_bucket_arn" {
  value = aws_s3_bucket.delivery_bucket_raw_data.arn
}

output "dynamodb_table_name" {
  value = aws_dynamodb_table.dynamodb-table.name
}

output "dynamodb_table_arn" {
  value = aws_dynamodb_table.dynamodb-table.arn
}