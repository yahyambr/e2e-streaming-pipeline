variable "project_tag" {
  type = string
}

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