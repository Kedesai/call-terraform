provider "aws" {
  region = var.aws_region
}

module "dynamodb" {
  source = "git::https://github.com/Kedesai/terraform.git//dynamodb?ref=832b9504a0cff0c7c1b73c47e43f0366ee4ce610"

  table_name  = var.table_name
  environment = var.environment

  billing_mode = var.billing_mode

  hash_key      = var.hash_key
  hash_key_type = var.hash_key_type

  range_key      = var.range_key
  range_key_type = var.range_key_type

  point_in_time_recovery = var.point_in_time_recovery

  ttl_attribute = var.ttl_attribute

  stream_enabled   = var.stream_enabled
  stream_view_type = var.stream_view_type

  server_side_encryption_kms_key_arn = var.server_side_encryption_kms_key_arn

  deletion_protection_enabled = var.deletion_protection_enabled

  tags = var.tags
}
