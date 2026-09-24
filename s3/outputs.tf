output "bucket_id" {
  description = "S3 bucket ID"
  value       = module.s3.bucket_id
}

output "bucket_arn" {
  description = "S3 bucket ARN"
  value       = module.s3.bucket_arn
}

output "bucket_domain_name" {
  description = "S3 bucket domain name"
  value       = module.s3.bucket_domain_name
}

output "bucket_regional_domain_name" {
  description = "S3 bucket regional domain name"
  value       = module.s3.bucket_regional_domain_name
}

output "bucket_hosted_zone_id" {
  description = "Route 53 hosted zone ID for the S3 bucket"
  value       = module.s3.bucket_hosted_zone_id
}
