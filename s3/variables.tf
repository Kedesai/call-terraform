variable "aws_region" {
  description = "AWS region"
  type        = string
}

variable "bucket_name" {
  description = "Name of the S3 bucket"
  type        = string
}

variable "environment" {
  description = "Environment name"
  type        = string
}

variable "versioning_enabled" {
  description = "Whether to enable bucket versioning"
  type        = bool
  default     = true
}

variable "enable_encryption" {
  description = "Whether to enable server-side encryption"
  type        = bool
  default     = true
}

variable "sse_algorithm" {
  description = "Server-side encryption algorithm"
  type        = string
  default     = "AES256"

  validation {
    condition     = contains(["AES256", "aws:kms"], var.sse_algorithm)
    error_message = "sse_algorithm must be AES256 or aws:kms."
  }
}

variable "kms_master_key_arn" {
  description = "KMS key ARN when using aws:kms encryption"
  type        = string
  default     = null
}

variable "block_public_acls" {
  description = "Block public ACLs"
  type        = bool
  default     = true
}

variable "block_public_policy" {
  description = "Block public bucket policies"
  type        = bool
  default     = true
}

variable "ignore_public_acls" {
  description = "Ignore public ACLs"
  type        = bool
  default     = true
}

variable "restrict_public_buckets" {
  description = "Restrict public buckets"
  type        = bool
  default     = true
}

variable "enable_lifecycle_rules" {
  description = "Whether to enable lifecycle rules"
  type        = bool
  default     = false
}

variable "lifecycle_transition_days" {
  description = "Days before transition to STANDARD_IA"
  type        = number
  default     = 30
}

variable "lifecycle_glacier_days" {
  description = "Days before transition to GLACIER"
  type        = number
  default     = 90
}

variable "lifecycle_expiration_days" {
  description = "Days before expiration"
  type        = number
  default     = 365
}

variable "force_destroy" {
  description = "Whether Terraform can destroy a non-empty bucket"
  type        = bool
  default     = false
}

variable "tags" {
  description = "Additional tags"
  type        = map(string)
  default     = {}
}
