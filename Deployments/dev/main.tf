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

module "vpc" {
  source               = "git::https://github.com/kedesai/Terraform.git//vpc?ref=main"
  vpc_cidr             = "10.0.0.0/16"
  environment          = "dev"
  public_subnet_cidrs  = ["10.0.1.0/24", "10.0.2.0/24"]
  private_subnet_cidrs = ["10.0.10.0/24", "10.0.11.0/24"]
  availability_zones   = ["us-east-1a", "us-east-1b"]
}

data "aws_vpc" "selected" {
  default = true
}

data "aws_subnets" "selected" {
  filter {
    name   = "vpc-id"
    values = [data.aws_vpc.selected.id]
  }
}

data "aws_ami" "free_tier" {
  most_recent = true
  owners      = ["amazon"]
  filter {
    name   = "name"
    values = ["al2023-ami-*-x86_64"]
  }
}

module "my_ec2" {
  source        = "git::https://github.com/kedesai/terraform.git//ec2?ref=main"
  instance_name = "manual-test-vm"
  environment   = "dev"
  subnet_id     = module.vpc.private_subnet_ids[0]

  tags = {
    Application = "webserver"
    Project     = "manual-setup"
    Environment = "dev"
    ManagedBy   = "manual"
    Owner       = "ketandesai"
  }
}
