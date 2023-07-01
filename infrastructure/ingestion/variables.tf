variable "project_tag" {
  type = string
}

variable "delivery_stream" {
  type = string
}

variable "delivery_bucket_arn" {
  type = string
}

variable "firehose_role" {
  type = string
}

variable "firehose_log_group_arn" {
  type = string
}

variable "firehole_role_inline_policy" {
  type = string
}
