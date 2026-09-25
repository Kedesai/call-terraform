output "db_instance_id" {
  description = "RDS instance ID"
  value       = module.rds.db_instance_id
}

output "db_instance_arn" {
  description = "RDS instance ARN"
  value       = module.rds.db_instance_arn
}

output "db_instance_endpoint" {
  description = "RDS connection endpoint"
  value       = module.rds.db_instance_endpoint
}

output "db_instance_address" {
  description = "RDS hostname"
  value       = module.rds.db_instance_address
}

output "db_instance_port" {
  description = "RDS database port"
  value       = module.rds.db_instance_port
}

output "db_instance_availability_zone" {
  description = "RDS availability zone"
  value       = module.rds.db_instance_availability_zone
}

output "db_subnet_group_name" {
  description = "RDS DB subnet group name"
  value       = module.rds.db_subnet_group_name
}
