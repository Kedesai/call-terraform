output "topic_arn" {
  description = "SNS topic ARN"
  value       = module.sns.topic_arn
}

output "topic_name" {
  description = "SNS topic name"
  value       = module.sns.topic_name
}

output "topic_id" {
  description = "SNS topic ID"
  value       = module.sns.topic_id
}

output "topic_owner" {
  description = "AWS account ID of the SNS topic owner"
  value       = module.sns.topic_owner
}
