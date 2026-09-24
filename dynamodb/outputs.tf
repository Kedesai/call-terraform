output "table_id" {
  description = "DynamoDB table ID"
  value       = module.dynamodb.table_id
}

output "table_arn" {
  description = "DynamoDB table ARN"
  value       = module.dynamodb.table_arn
}

output "table_name" {
  description = "DynamoDB table name"
  value       = module.dynamodb.table_name
}
