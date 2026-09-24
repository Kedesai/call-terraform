provider "aws" {
  region = var.aws_region
}

module "s3" {
  source = "git::https://github.com/Kedesai/terraform.git//s3?ref=main"

  bucket_name = var.bucket_name
  environment = var.environment

  versioning_enabled = var.versioning_enabled

  enable_encryption  = var.enable_encryption
  sse_algorithm      = var.sse_algorithm
  kms_master_key_arn = var.kms_master_key_arn

  block_public_acls       = var.block_public_acls
  block_public_policy     = var.block_public_policy
  ignore_public_acls      = var.ignore_public_acls
  restrict_public_buckets = var.restrict_public_buckets

  enable_lifecycle_rules    = var.enable_lifecycle_rules
  lifecycle_transition_days = var.lifecycle_transition_days
  lifecycle_glacier_days    = var.lifecycle_glacier_days
  lifecycle_expiration_days = var.lifecycle_expiration_days

  force_destroy = var.force_destroy

  tags = var.tags
}
