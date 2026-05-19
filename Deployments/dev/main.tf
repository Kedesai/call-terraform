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
  filter {
    name   = "tag:Environment"
    values = ["dev"]
  }
}

data "aws_subnets" "selected" {
  filter {
    name   = "vpc-id"
    values = [data.aws_vpc.selected.id]
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
