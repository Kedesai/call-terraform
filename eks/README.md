# EKS Deployment

Terraform calling configuration for deploying Amazon EKS using the reusable module:

```text
Kedesai/terraform/eks
```

## Module Source

```hcl
module "eks" {
  source = "git::https://github.com/Kedesai/terraform.git//eks?ref=main"
}
```

For production, use a version tag or commit SHA instead of `main`.

## Directory Structure

```text
eks/
├── main.tf
├── variables.tf
├── terraform.tfvars
├── outputs.tf
├── versions.tf
└── README.md
```

## Required Variables

```text
region
cluster_name
subnet_ids
created_by
```

## Deployment Parameters

Example:

```hcl
region = "us-east-1"

cluster_name    = "ketan-eks-dev"
cluster_version = "1.34"

subnet_ids = [
  "subnet-0ef6e2bfb64babf65",
  "subnet-0f488043a31321b72"
]

enable_irsa                  = false
enable_cluster_creator_admin = true

node_groups = {
  general = {
    instance_types = ["t3a.small"]
    desired_size   = 1
    min_size       = 1
    max_size       = 2
    capacity_type  = "ON_DEMAND"
  }
}

created_by = "ketan"

tags = {
  Application = "terraform-gitops-test"
  Environment = "dev"
  Owner       = "ketan"
}
```

## Networking

The EKS deployment consumes existing AWS subnets.

```hcl
subnet_ids = [
  "subnet-xxxxxxxx",
  "subnet-yyyyyyyy"
]
```

The EKS module does not require the caller to create networking.

## IAM Roles

The reusable module supports either creating or consuming existing EKS IAM roles.

Optional existing roles:

```text
cluster_role_arn
node_role_arn
```

When the role ARNs are not provided, the reusable module creates the required EKS cluster and node roles.

## Node Groups
 
Managed node groups are supplied by the caller.
 
Example:
 
```hcl
node_groups = {
general = {
instance_types = ["t3a.small"]
desired_size = 1
min_size = 1
max_size = 2
capacity_type = "ON_DEMAND"
}
}
```
 
## HCP Terraform Workspace
 
```text
Repository: Kedesai/call-terraform
Working Directory: eks
 
VCS Trigger: Branch-based
VCS Branch: Default branch
 
Trigger Syntax: Patterns
Trigger Path: eks/**/*
 
Speculative PR Plans: Enabled
Auto Apply: Disabled
Submodule Cloning: Disabled
```
 
## HCP Terraform Variables
 
Typical workspace variables:
 
```text
region
cluster_name
created_by
subnet_ids
```
 
Structured non-sensitive configuration such as node groups can remain in `terraform.tfvars`.
 
## AWS Credentials
 
AWS credentials must NOT be committed to the GitHub repository or Terraform configuration.
 
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
 
Recommended:
 
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
AWS EKS
```
 
## Outputs
 
```text
cluster_name
cluster_endpoint
cluster_ca
oidc_provider_arn
```

Managed node groups are 
