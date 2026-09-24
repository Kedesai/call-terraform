output "instance_id" {
  description = "EC2 instance ID"
  value       = module.ec2.instance_id
}

output "instance_arn" {
  description = "EC2 instance ARN"
  value       = module.ec2.instance_arn
}

output "private_ip" {
  description = "Private IP address"
  value       = module.ec2.private_ip
}

output "private_dns" {
  description = "Private DNS name"
  value       = module.ec2.private_dns
}

output "availability_zone" {
  description = "Availability zone"
  value       = module.ec2.availability_zone
}
