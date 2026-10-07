provider "aws" {
  region = var.aws_region
}

module "alb" {
  source = "git::https://github.com/Kedesai/terraform.git//alb?ref=832b9504a0cff0c7c1b73c47e43f0366ee4ce610"

  alb_name    = var.alb_name
  environment = var.environment

  subnets         = var.subnets
  security_groups = var.security_groups

  internal           = var.internal
  ip_address_type    = var.ip_address_type
  load_balancer_type = "application"

  enable_deletion_protection = var.enable_deletion_protection
  enable_http2               = var.enable_http2

  target_groups = var.target_groups
  listeners     = var.listeners

  tags = var.tags
}
