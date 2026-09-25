aws_region = "us-east-1"

role_name   = "ketan-terraform-ec2-role"
environment = "dev"

description = "EC2 role created through Terraform GitOps"

create_instance_profile = true

managed_policy_arns = []

inline_policies = {}

tags = {
  Application = "terraform-gitops-test"
  Environment = "dev"
  Owner       = "ketan"
}
