variable "aws_region" {
  description = "AWS region"
  type        = string
}

variable "db_instance_identifier" {
  description = "RDS instance identifier"
  type        = string
}

variable "environment" {
  description = "Environment name"
  type        = string
}

variable "engine" {
  description = "Database engine"
  type        = string
}

variable "engine_version" {
  description = "Database engine version"
  type        = string
}

variable "instance_class" {
  description = "RDS instance class"
  type        = string
}

variable "allocated_storage" {
  description = "Allocated storage in GB"
  type        = number
}

variable "max_allocated_storage" {
  description = "Maximum allocated storage for autoscaling"
  type        = number
  default     = 0
}

variable "storage_type" {
  description = "RDS storage type"
  type        = string
  default     = "gp3"
}

variable "db_name" {
  description = "Initial database name"
  type        = string
  default     = null
}

variable "username" {
  description = "RDS master username"
  type        = string
  sensitive   = true
}

variable "password" {
  description = "RDS master password"
  type        = string
  sensitive   = true
}

variable "db_subnet_group_name" {
  description = "Name of the DB subnet group"
  type        = string
}

variable "db_subnet_group_description" {
  description = "Description of the DB subnet group"
  type        = string
  default     = "RDS subnet group managed by Terraform"
}

variable "db_subnet_ids" {
  description = "Existing subnet IDs used by the RDS subnet group"
  type        = list(string)
}

variable "vpc_security_group_ids" {
  description = "Existing security groups for RDS"
  type        = list(string)
}

variable "multi_az" {
  description = "Enable Multi-AZ"
  type        = bool
  default     = false
}

variable "backup_retention_period" {
  description = "Backup retention period in days"
  type        = number
  default     = 7
}

variable "performance_insights_enabled" {
  description = "Enable Performance Insights"
  type        = bool
  default     = false
}

variable "skip_final_snapshot" {
  description = "Skip final snapshot during deletion"
  type        = bool
  default     = true
}

variable "deletion_protection" {
  description = "Enable deletion protection"
  type        = bool
  default     = false
}

variable "apply_immediately" {
  description = "Apply database changes immediately"
  type        = bool
  default     = false
}

variable "kms_key_id" {
  description = "KMS key ID used for RDS encryption"
  type        = string
  default     = null
}

variable "tags" {
  description = "Additional RDS tags"
  type        = map(string)
  default     = {}
}
