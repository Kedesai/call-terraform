variable "aws_region" {
  description = "AWS region"
  type        = string
}

variable "environment" {
  description = "Environment name"
  type        = string
}

variable "create_vpc" {
  description = "Whether Terraform should create a new VPC"
  type        = bool
  default     = false
}

variable "existing_vpc_id" {
  description = "Existing VPC ID when create_vpc is false"
  type        = string
  default     = null
}

variable "existing_public_subnet_ids" {
  description = "Existing public subnet IDs"
  type        = list(string)
  default     = []
}

variable "existing_private_subnet_ids" {
  description = "Existing private subnet IDs"
  type        = list(string)
  default     = []
}

variable "vpc_cidr" {
  description = "CIDR used when creating a new VPC"
  type        = string
  default     = "10.50.0.0/16"
}

variable "availability_zones" {
  description = "Availability zones used when creating subnets"
  type        = list(string)

  default = [
    "us-east-1a",
    "us-east-1b"
  ]
}

variable "public_subnet_cidrs" {
  description = "Public subnet CIDRs when creating networking"
  type        = list(string)
  default     = []
}

variable "private_subnet_cidrs" {
  description = "Private subnet CIDRs when creating networking"
  type        = list(string)
  default     = []
}

variable "enable_nat_gateway" {
  description = "Whether to create a NAT Gateway"
  type        = bool
  default     = false
}

variable "single_nat_gateway" {
  description = "Use a single NAT Gateway"
  type        = bool
  default     = true
}

variable "enable_dns_hostnames" {
  description = "Enable VPC DNS hostnames"
  type        = bool
  default     = true
}

variable "enable_dns_support" {
  description = "Enable VPC DNS support"
  type        = bool
  default     = true
}

variable "enable_flow_logs" {
  description = "Enable VPC Flow Logs"
  type        = bool
  default     = false
}

variable "flow_logs_traffic_type" {
  description = "VPC Flow Log traffic type"
  type        = string
  default     = "ALL"
}

variable "tags" {
  description = "Additional tags"
  type        = map(string)
  default     = {}
}
