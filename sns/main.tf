provider "aws" {
  region = var.aws_region
}

module "sns" {
  source = "git::https://github.com/Kedesai/terraform.git//sns?ref=34dbcabc1f4a6d2ec15a57d20ff087aa78947b84"

  topic_name   = var.topic_name
  environment  = var.environment
  display_name = var.display_name

  kms_master_key_id = var.kms_master_key_id

  fifo_topic                  = var.fifo_topic
  content_based_deduplication = var.content_based_deduplication

  subscriptions = var.subscriptions

  tags = var.tags
}
