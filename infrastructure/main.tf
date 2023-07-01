provider "aws" {
  region = var.region
}

module "monitoring" {
  source = "./monitoring"
  project_tag = var.project_tag
  log_group_retention_days = var.log_group_retention_days
  lambda_transformer_function_name = var.lambda_transformer_function_name
  lambda_extractor_function_name = var.lambda_extractor_function_name
  delivery_stream_name = var.delivery_stream
}

module "storage" {
  source = "./storage"
  project_tag = var.project_tag
  hash_key = var.hash_key
  range_key = var.range_key
  hash_key_type = var.hash_key_type
  range_key_type = var.range_key_type
  raw_data_bucket_name = var.raw_data_bucket_name
  table_name = var.table_name
  read_capacity = var.read_capacity
  write_capacity = var.write_capacity
}

module "ingestion" {
  source = "./ingestion"
  project_tag = var.project_tag
  delivery_bucket_arn = module.storage.delivery_bucket_arn
  delivery_stream = var.delivery_stream
  firehose_role = var.firehose_role
  firehole_role_inline_policy = var.firehole_role_inline_policy
  firehose_log_group_arn = module.monitoring.firehose_log_group_arn
}

module "compute" {
  source = "./compute"
  lambda_transformer_source_file = var.lambda_transformer_source_file
  lambda_transformer_output_path = var.lambda_transformer_output_path
  runtime = var.runtime
  lambda_transformer_archive_type = var.lambda_transformer_archive_type
  project_tag = var.project_tag
  lambda_transformer_filename = var.lambda_transformer_filename
  lambda_transformer_function_name = var.lambda_transformer_function_name
  lambda_transformer_handler_name = var.lambda_transformer_handler_name
  lambda_transformer_log_group_arn = module.monitoring.lambda_transformer_log_group_arn
  lambda_transformer_role = var.lambda_transformer_role
  lambda_transformer_role_inline_policy = var.lambda_transformer_role_inline_policy
  lambda_transformer_layers = var.lambda_transformer_layers
  delivery_bucket_id = module.storage.delivery_bucket_id
  delivery_bucket_arn = module.storage.delivery_bucket_arn
  dynamodb_table_arn = module.storage.dynamodb_table_arn
}

module "scheduling" {
  source = "./scheduling"
  project_tag = var.project_tag
  runtime = var.runtime
  lambda_extractor_filename = var.lambda_extractor_filename
  lambda_extractor_function_name = var.lambda_extractor_function_name
  lambda_extractor_handler_name = var.lambda_extractor_handler_name
  lambda_extractor_archive_type = var.lambda_extractor_archive_type
  lambda_extractor_output_path = var.lambda_extractor_output_path
  lambda_extractor_role_inline_policy = var.lambda_extractor_role_inline_policy
  lambda_extractor_role = var.lambda_extractor_role
  lambda_extractor_source_file = var.lambda_extractor_source_file
  lambda_extractor_log_group_arn = module.monitoring.lambda_extractor_log_group_arn
  flexible_time = var.flexible_time
  scheduler_name = var.scheduler_name
  schedule_expression = var.schedule_expression
  scheduler_role_inline_policy = var.scheduler_role_inline_policy
  fihrehose_delivery_stream_arn = module.ingestion.fihrehose_delivery_stream_arn
}