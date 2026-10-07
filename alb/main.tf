provider "aws" {
  region = var.aws_region
}

module "alb" {
  source = "git::https://github.com/Kedesai/terraform.git//alb?ref=34dbcabc1f4a6d2ec15a57d20ff087aa78947b84"

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
