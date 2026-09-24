variable "aws_region" {
  description = "AWS region"
  type        = string
}

variable "table_name" {
  description = "Name of the DynamoDB table"
  type        = string
}

variable "environment" {
  description = "Environment name"
  type        = string
}

variable "billing_mode" {
  description = "DynamoDB billing mode"
  type        = string
  default     = "PAY_PER_REQUEST"

  validation {
    condition = contains(
      ["PAY_PER_REQUEST", "PROVISIONED"],
      var.billing_mode
    )
    error_message = "billing_mode must be PAY_PER_REQUEST or PROVISIONED."
  }
}

variable "hash_key" {
  description = "Partition key name"
  type        = string
}

variable "hash_key_type" {
  description = "Partition key type"
  type        = string
  default     = "S"

  validation {
    condition     = contains(["S", "N", "B"], var.hash_key_type)
    error_message = "hash_key_type must be S, N, or B."
  }
}

variable "range_key" {
  description = "Optional sort key name"
  type        = string
  default     = null
}

variable "range_key_type" {
  description = "Sort key type"
  type        = string
  default     = "S"
}

variable "point_in_time_recovery" {
  description = "Enable point-in-time recovery"
  type        = bool
  default     = true
}

variable "ttl_attribute" {
  description = "Optional TTL attribute"
  type        = string
  default     = null
}

variable "stream_enabled" {
  description = "Enable DynamoDB Streams"
  type        = bool
  default     = false
}

variable "stream_view_type" {
  description = "DynamoDB stream view type"
  type        = string
  default     = "NEW_AND_OLD_IMAGES"
}

variable "server_side_encryption_kms_key_arn" {
  description = "Optional KMS key ARN"
  type        = string
  default     = null
}

variable "deletion_protection_enabled" {
  description = "Enable deletion protection"
  type        = bool
  default     = false
}

variable "tags" {
  description = "Additional tags"
  type        = map(string)
  default     = {}
}
