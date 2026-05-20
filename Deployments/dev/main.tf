terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0"
    }
  }
}


backend "s3" {
    bucket         = "ketan-terraform-state-bucket"
    key            = "dev/terraform.tfstate"
    region         = "us-east-1"
    encrypt        = true
    dynamodb_table = "terraform-lock-table"
  }


provider "aws" {
  region = "us-east-1"
}

module "vpc" {
  source               = "git::https://github.com/kedesai/Terraform.git//vpc?ref=main"
  vpc_cidr             = "10.0.0.0/16"
  environment          = "dev"
  public_subnet_cidrs  = ["10.0.1.0/24", "10.0.2.0/24"]
  private_subnet_cidrs = ["10.0.10.0/24", "10.0.11.0/24"]
  availability_zones   = ["us-east-1a", "us-east-1b"]
}

#data "aws_ami" "free_tier" {
#  most_recent = true
#  owners      = ["amazon"]
#  filter {
#    name   = "name"
#    values = ["al2023-ami-*-x86_64"]
#  }
#}

#module "my_ec2" {
#  source        = "git::https://github.com/kedesai/terraform.git//ec2?ref=main"
#  instance_name = "manual-test-vm"
#  environment   = "dev"
#  subnet_id     = module.vpc.private_subnet_ids[0]

#  tags = {
#    Application = "webserver"
#    Project     = "manual-setup"
#    Environment = "dev"
#    ManagedBy   = "manual"
#    Owner       = "ketandesai"
#  }
#}


#################################
# EKS MODULE
#################################

module "eks" {
  source = "git::https://github.com/kedesai/terraform-aws-eks.git?ref=v1.0.0"

  region       = "us-east-1"
  cluster_name = "dev-eks"

  #################################
  # NETWORKING FROM VPC
  #################################

  vpc_id     = module.vpc.vpc_id
  subnet_ids = module.vpc.private_subnet_ids

  #################################
  # NODE GROUPS
  #################################

  node_groups = {
    default = {
      instance_types = ["t3.small"]
      desired_size   = 1
      min_size       = 1
      max_size       = 2
      capacity_type  = "ON_DEMAND"
    }

    spot = {
      instance_types = ["t3.small"]
      desired_size   = 1
      min_size       = 0
      max_size       = 1
      capacity_type  = "SPOT"
    }
  }

  #################################
  # TAGS
  #################################

  tags = {
    Environment = "dev"
    CostCenter   = "eng-dev"
    Owner       = "ketandesai"
    Application  = "webserver"
    CreatedBy = var.created_by   
    Pipeline   = var.pipeline_name
    RunId      = var.run_id
    Managed   = "terraform"
  }
}

#################################
# OUTPUTS
#################################

output "vpc_id" {
  value = module.vpc.vpc_id
}

output "private_subnets" {
  value = module.vpc.private_subnet_ids
}

output "ec2_instance_id" {
  value = module.my_ec2.instance_id
}

output "eks_cluster_name" {
  value = module.eks.cluster_name
}

output "eks_endpoint" {
  value = module.eks.cluster_endpoint
}
