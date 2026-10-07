provider "aws" {
  region = var.aws_region
}

module "vpc" {
  source = "git::https://github.com/Kedesai/terraform.git//vpc?ref=832b9504a0cff0c7c1b73c47e43f0366ee4ce610"

  create_vpc  = var.create_vpc
  environment = var.environment

  # Used only when creating a new VPC
  vpc_cidr             = var.vpc_cidr
  availability_zones   = var.availability_zones
  public_subnet_cidrs  = var.public_subnet_cidrs
  private_subnet_cidrs = var.private_subnet_cidrs

  # Existing networking
  existing_vpc_id             = var.existing_vpc_id
  existing_public_subnet_ids  = var.existing_public_subnet_ids
  existing_private_subnet_ids = var.existing_private_subnet_ids

  enable_nat_gateway = var.enable_nat_gateway
  single_nat_gateway = var.single_nat_gateway

  enable_dns_hostnames = var.enable_dns_hostnames
  enable_dns_support   = var.enable_dns_support

  enable_flow_logs       = var.enable_flow_logs
  flow_logs_traffic_type = var.flow_logs_traffic_type

  tags = var.tags
}
