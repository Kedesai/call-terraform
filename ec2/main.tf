provider "aws" {
  region = var.aws_region
}

module "ec2" {
  source = "git::https://github.com/Kedesai/terraform.git//ec2?ref=main"

  instance_name = var.instance_name
  environment   = var.environment
  instance_type = var.instance_type
  ami_id        = var.ami_id
  ami_owner     = var.ami_owner
  ami_name      = var.ami_name

  subnet_id              = var.subnet_id
  vpc_security_group_ids = var.vpc_security_group_ids

  associate_public_ip = false

  root_volume_size      = var.root_volume_size
  root_volume_type      = var.root_volume_type
  root_volume_encrypted = true

  tags = var.tags
}
