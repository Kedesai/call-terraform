variable "region" {
  description = "AWS region"
  type        = string
}

variable "cluster_name" {
  description = "EKS cluster name"
  type        = string
}

variable "cluster_version" {
  description = "Kubernetes version"
  type        = string
  default     = "1.34"
}

variable "subnet_ids" {
  description = "Existing subnet IDs for EKS"
  type        = list(string)
}

variable "enable_irsa" {
  description = "Enable IAM Roles for Service Accounts"
  type        = bool
  default     = false
}

variable "cluster_role_arn" {
  description = "Existing EKS control-plane IAM role ARN"
  type        = string
  default     = null
}

variable "node_role_arn" {
  description = "Existing EKS managed node IAM role ARN"
  type        = string
  default     = null
}

variable "enable_cluster_creator_admin" {
  description = "Grant cluster creator administrator access"
  type        = bool
  default     = true
}

variable "node_groups" {
  description = "EKS managed node groups"

  type = map(object({
    instance_types = list(string)
    desired_size   = number
    min_size       = number
    max_size       = number
    capacity_type  = string
  }))

  default = {}
}

variable "pipeline_name" {
  description = "Pipeline that triggered Terraform"
  type        = string
  default     = "hcp-terraform"
}

variable "run_id" {
  description = "Pipeline run identifier"
  type        = string
  default     = "manual"
}

variable "created_by" {
  description = "Creator identifier"
  type        = string
}

variable "tags" {
  description = "Additional EKS tags"
  type        = map(string)
  default     = {}
}
