variable "aws_region" {
  description = "AWS region"
  type        = string
}

variable "instance_name" {
  description = "Name of the EC2 instance"
  type        = string
}

variable "environment" {
  description = "Environment name"
  type        = string
}

variable "instance_type" {
  description = "EC2 instance type"
  type        = string
  default     = "t3a.large"
}

variable "ami_id" {
  description = "AMI ID"
  type        = string
  default     = null
}

variable "ami_owner" {
  description = "AWS account ID that owns the approved AMI"
  type        = string
}

variable "ami_name" {
  description = "Approved AMI name"
  type        = string
}

variable "subnet_id" {
  description = "Existing subnet ID"
  type        = string
}

variable "vpc_security_group_ids" {
  description = "Existing security group IDs"
  type        = list(string)
  default     = []
}

variable "root_volume_size" {
  description = "Root EBS volume size in GB"
  type        = number
  default     = 8
}

variable "root_volume_type" {
  description = "Root EBS volume type"
  type        = string
  default     = "gp3"
}

variable "tags" {
  description = "Additional EC2 tags"
  type        = map(string)
  default     = {}
}
