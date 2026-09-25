variable "aws_region" {
  description = "AWS region"
  type        = string
}

variable "topic_name" {
  description = "Name of the SNS topic"
  type        = string
}

variable "environment" {
  description = "Environment name"
  type        = string
}

variable "display_name" {
  description = "Display name for the SNS topic"
  type        = string
  default     = null
}

variable "kms_master_key_id" {
  description = "Optional KMS key ID for SNS server-side encryption"
  type        = string
  default     = null
}

variable "fifo_topic" {
  description = "Whether to create a FIFO SNS topic"
  type        = bool
  default     = false
}

variable "content_based_deduplication" {
  description = "Enable content-based deduplication for FIFO topics"
  type        = bool
  default     = false
}

variable "subscriptions" {
  description = "SNS topic subscriptions"

  type = list(object({
    protocol             = string
    endpoint             = string
    endpoint_id          = optional(string)
    raw_message_delivery = optional(bool, false)
    filter_policy        = optional(string)
    filter_policy_scope  = optional(string, "MessageAttributes")
  }))

  default = []
}

variable "tags" {
  description = "Additional SNS topic tags"
  type        = map(string)
  default     = {}
}
