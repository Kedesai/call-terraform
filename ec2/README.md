# EC2 Deployment
 
Terraform calling configuration for deploying EC2 using the reusable module:
 
```text
Kedesai/terraform/ec2
```
 
## Module Source
 
```hcl
module "ec2" {
source = "git::https://github.com/Kedesai/terraform.git//ec2?ref=main"
}
```
 
For production, use a version tag or commit SHA instead of `main`.
 
## Directory Structure
 
```text
ec2/
├── main.tf
├── variables.tf
├── terraform.tfvars
├── outputs.tf
├── versions.tf
└── README.md
```
 
## Required Variables
 
```text
aws_region
instance_name
environment
subnet_id
```
 
## Deployment Parameters
 
Typical EC2 configuration:
 
```hcl
aws_region = "us-east-1"
 
instance_name = "ketan-test-ec2"
environment = "dev"
 
instance_type = "t3a.small"
 
ami_owner = "853826937896"
ami_name = "UBUNTU-22-PRO-x86 2026-09-01T08-00-32.122Z"
 
subnet_id = "subnet-xxxxxxxx"
 
vpc_security_group_ids = [
"sg-xxxxxxxx"
]
 
associate_public_ip = false
 
root_volume_size = 20
root_volume_type = "gp3"
 
tags = {
Application = "terraform-test"
Environment = "dev"
Owner = "ketan"
}
```
 
## Networking
 
The EC2 deployment consumes existing AWS networking.
 
Required:
 
```text
Existing subnet
Existing security group
```
 
Example:
 
```hcl
subnet_id = "subnet-xxxxxxxx"
 
vpc_security_group_ids = [
"sg-xxxxxxxx"
]
```
 
The caller does not need to create networking.
 
## Approved AMI
 
The deployment supports selecting an approved AMI by owner and image name:
 
```hcl
ami_owner = "853826937896"
ami_name = "UBUNTU-22-PRO-x86 2026-09-01T08-00-32.122Z"
```
 
The reusable EC2 module resolves the corresponding AMI ID.
 
## HCP Terraform Workspace
 
```text
Repository: Kedesai/call-terraform
Working Directory: ec2
 
VCS Trigger: Branch-based
VCS Branch: Default branch
 
Trigger Syntax: Patterns
Trigger Path: ec2/**/*
 
Speculative PR Plans: Enable**Auto Apply: Disabled
S**module Cloning: Disabled
```
 
## HCP Terraform Variables
 
Environment-specific variables can be configured in the HCP workspace:
 
```text
aws_region
instance_name
environment
```
 
Non-sensitive structured configuration can remain in `terraform.tfvars`.
 
## AWS Credentials
 
AWS credentials must NOT be stored in GitHub or committed in Terraform files.
 
Do not store:
 
```text
AWS_ACCESS_KEY_ID
AWS_SECRET_ACCESS_KEY
AWS_SESSION_TOKEN
```
 
in:
 
```text
main.tf
variables.tf
terraform.tfvars
README.md
```
 
AWS authentication should be provided through HCP Terraform.
 
Recommended approaches:
 
```text
HCP Terraform Variable Set
```
 
or preferably:
 
```text
HCP Terraform dynamic AWS credentials / OIDC
```
 
## GitOps Workflow
 
```text
Feature Branch
↓
Pull Request
↓
HCP Terraform Speculative Plan
↓
Review
↓
Merge to Default Branch
↓
HCP Terraform Plan
↓
Manual Approval
↓
Terraform Apply
↓
AWS EC2
```
 
## Outputs
 
```text
instance_id
instance_arn
private_ip
private_dns
availability_zone
```
