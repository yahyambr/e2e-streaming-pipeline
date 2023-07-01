resource "aws_s3_bucket" "delivery_bucket_raw_data" {
  bucket = var.raw_data_bucket_name

  tags = {
    project = var.project_tag
  }
}

resource "aws_dynamodb_table" "dynamodb-table" {
  name           = var.table_name
  read_capacity  = var.read_capacity
  write_capacity = var.write_capacity
  hash_key       = var.hash_key
  range_key      = var.range_key

  attribute {
    name = var.hash_key
    type = var.hash_key_type
  }

  attribute {
    name = var.range_key
    type = var.range_key_type
  }

  tags = {
    project = var.project_tag
  }
}