variable "aws_region" {
  description = "AWS region"
  type        = string
}

variable "role_name" {
  description = "IAM role name"
  type        = string
}

variable "environment" {
  description = "Environment name"
  type        = string
}

variable "description" {
  description = "IAM role description"
  type        = string
  default     = "Terraform managed EC2 role"
}

variable "max_session_duration" {
  description = "Maximum session duration"
  type        = number
  default     = 3600
}

variable "managed_policy_arns" {
  description = "Managed policies to attach"
  type        = list(string)
  default     = []
}

variable "inline_policies" {
  description = "Inline IAM policies"

  type = map(object({
    policy = string
  }))

  default = {}
}

variable "create_instance_profile" {
  description = "Create EC2 instance profile"
  type        = bool
  default     = true
}

variable "tags" {
  description = "Additional tags"
  type        = map(string)
  default     = {}
}
