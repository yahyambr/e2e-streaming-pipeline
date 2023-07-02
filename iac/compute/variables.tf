variable "project_tag" {
  type = string
}

variable "delivery_bucket_arn" {
  type = string
}

variable "delivery_bucket_id" {
  type = string
}

variable "dynamodb_table_arn" {
  type = string
}

variable "lambda_transformer_log_group_arn" {
  type = string
}

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