terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0"
    }
  }
}

provider "aws" {
  region = "us-east-1"
}

#module "vpc" {
#  source               = "git::https://github.com/kedesai/Terraform.git//vpc?ref=main"
#  vpc_cidr             = "10.0.0.0/16"
#  environment          = "dev"
#  public_subnet_cidrs  = ["10.0.1.0/24", "10.0.2.0/24"]
#  private_subnet_cidrs = ["10.0.10.0/24", "10.0.11.0/24"]
#  availability_zones   = ["us-east-1a", "us-east-1b"]
#}

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
#  # subnet_id     = module.vpc.private_subnet_ids[0]#

#  tags = {
#    Application = "webserver"
#    Project     = "manual-setup"
#    Environment = "dev"
#    ManagedBy   = "manual"
#    Owner       = "ketandesai"
#  }
#}

#################################
# EXISTING VPC
#################################

data "aws_vpc" "existing" {
  id = "vpc-0df35472004c2a07d" #  replace with your VPC ID
}

#################################
# EXISTING PRIVATE SUBNETS
#################################

data "aws_subnets" "private" {
  filter {
    name   = "vpc-id"
    values = [data.aws_vpc.existing.id]
  }

  # OPTIONAL: filter private subnets only (recommended)
  tags = {
    Type = "private"
  }
}


module "eks" {
  source = "git::https://github.com/kedesai/terraform.git//eks?ref=main"

  region       = "us-east-1"
  cluster_name = "dev-eks"

  #################################
  # NETWORKING
  #################################

  vpc_id     = data.aws_vpc.existing.id
  subnet_ids = [
    "subnet-0ef6e2bfb64babf65",  # us-east-1a
    "subnet-0f488043a31321b72"   # us-east-1b
  ]


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
  }

  #################################
  # TAGS
  #################################

  tags = {
    Name        = "dev-eks"
    Environment = "dev"

    ManagedBy = "terraform"
    Owner     = "ketandesai"

    "kubernetes.io/cluster/dev-eks" = "owned"
  }
}
