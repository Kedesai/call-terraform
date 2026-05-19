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
  subnet_id     = data.aws_subnets.selected.ids[0]

  tags = {
    Application = "webserver"
    Project     = "manual-setup"
    Environment = "dev"
    ManagedBy   = "manual"
    Owner       = "ketandesai"
  }
}
