variable "aws_region" { type = string; default = "us-east-2" }
variable "default_tags" { type = map(string); default = {} }
variable "feature_set" { type = string; default = "ALL" }
variable "enabled_policy_types" { type = list(string); default = ["SERVICE_CONTROL_POLICY"] }
variable "aws_service_access_principals" { type = list(string); default = [] }
variable "organizational_units" {
  type = map(object({ name = string, tags = optional(map(string), {}) }))
  default = {}
}
variable "accounts" {
  type = map(object({
    name = string, email = string, ou_key = string, role_name = optional(string),
    iam_user_access_to_billing = optional(string, "DENY"), close_on_deletion = optional(bool, false),
    tags = optional(map(string), {})
  }))
  default = {}
}
variable "service_control_policies" {
  type = map(object({ name = string, description = optional(string), content = string, tags = optional(map(string), {}) }))
  default = {}
}
variable "scp_attachments" {
  type = map(object({ policy_key = string, target_type = string, target_key = optional(string) }))
  default = {}
}
