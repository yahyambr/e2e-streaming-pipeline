variable "project_tag" {
  type = string
}

variable "log_group_retention_days" {
  type = number
}

variable "delivery_stream_name" {
  type = string
}

variable "lambda_transformer_function_name" {
  type = string
}

variable "lambda_extractor_function_name" {
  type = string
}