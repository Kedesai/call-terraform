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

Managed node groups are 
