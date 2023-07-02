resource "aws_kinesis_firehose_delivery_stream" "firehose_delivery_stream" {
    name = var.delivery_stream
    destination = "extended_s3"
   
    extended_s3_configuration {
      role_arn = aws_iam_role.firehose_role.arn
      bucket_arn = var.delivery_bucket_arn
      buffering_size = 1
      buffering_interval = 60
    }

    tags = {
      project = var.project_tag
    }
}

resource "aws_iam_role" "firehose_role" {
    name = var.firehose_role
    assume_role_policy = data.aws_iam_policy_document.firehose_assume_role_policy.json
    inline_policy {
      name = var.firehole_role_inline_policy
      policy = data.aws_iam_policy_document.firehose_role_inline_policy.json
    }
    tags = {
      project = var.project_tag
    }
}

data "aws_iam_policy_document" "firehose_assume_role_policy" {
  statement {
    actions = ["sts:AssumeRole"]
    principals {
      type        = "Service"
      identifiers = ["firehose.amazonaws.com"]
    }
  }
}

data "aws_iam_policy_document" "firehose_role_inline_policy" {
  statement {
    actions   = ["s3:GetObject", "s3:ListBucket", "s3:PutObject"]
    resources = [var.delivery_bucket_arn, "${var.delivery_bucket_arn}/*"]
  }
  statement {
    actions = ["logs:PutLogEvents", "logs:CreateLogStream"]
    resources = ["${var.firehose_log_group_arn}:*"]
  }
}