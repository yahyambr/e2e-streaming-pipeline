# general
variable "project_tag" {
  type = string
}

variable "region" {
  type = string
}

# monitoring
variable "log_group_retention_days" {
  type = number
}

# storage
variable "raw_data_bucket_name" {
  type = string
}

variable "table_name" {
  type = string
}

variable "read_capacity" {
  type = string
}

variable "write_capacity" {
  type = number
}

variable "hash_key" {
  type = string
}

variable "hash_key_type" {
  type = string
}

variable "range_key" {
  type = string
}

variable "range_key_type" {
  type = string
}

# ingestion
variable "delivery_stream" {
  type = string
}

variable "firehose_role" {
  type = string
}

variable "firehole_role_inline_policy" {
  type = string
}

# compute
variable "lambda_transformer_source_file" {
  type = string
}

variable "lambda_transformer_output_path" {
  type = string
}

variable "lambda_transformer_archive_type" {
  type = string
}
variable "lambda_transformer_role" {
  type = string
}

variable "lambda_transformer_role_inline_policy" {
  type = string
}

variable "lambda_transformer_function_name" {
  type = string
}

variable "lambda_transformer_filename" {
  type = string
}

variable "lambda_transformer_handler_name" {
  type = string
}

variable "runtime" {
  type = string
}

variable "lambda_transformer_layers" {
  type = list(string)
}

#scheduling
variable "lambda_extractor_role" {
  type = string
}

variable "lambda_extractor_role_inline_policy" {
  type = string
}

variable "scheduler_role_inline_policy" {
  type = string
}

variable "lambda_extractor_archive_type" {
  type = string
}

variable "lambda_extractor_source_file" {
  type = string
}

variable "lambda_extractor_output_path" {
  type = string
}

variable "lambda_extractor_function_name" {
  type = string
}

variable "lambda_extractor_filename" {
  type = string
}

variable "lambda_extractor_handler_name" {
  type = string
}

variable "scheduler_name" {
  type = string
}

variable "flexible_time" {
  type = string
}

variable "schedule_expression" {
  type = string
}