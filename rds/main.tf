provider "aws" {
  region = var.aws_region
}

module "rds" {
  source = "git::https://github.com/Kedesai/terraform.git//rds?ref=main"

  db_instance_identifier = var.db_instance_identifier
  environment            = var.environment

  engine         = var.engine
  engine_version = var.engine_version
  instance_class = var.instance_class

  allocated_storage     = var.allocated_storage
  max_allocated_storage = var.max_allocated_storage
  storage_type          = var.storage_type

  db_name  = var.db_name
  username = var.username
  password = var.password

  create_db_subnet_group      = true
  db_subnet_group_name        = var.db_subnet_group_name
  db_subnet_group_description = var.db_subnet_group_description
  db_subnet_ids               = var.db_subnet_ids

  vpc_security_group_ids = var.vpc_security_group_ids

  multi_az            = var.multi_az
  publicly_accessible = false

  backup_retention_period = var.backup_retention_period

  performance_insights_enabled = var.performance_insights_enabled

  skip_final_snapshot = var.skip_final_snapshot
  deletion_protection = var.deletion_protection

  apply_immediately = var.apply_immediately

  kms_key_id = var.kms_key_id

  tags = var.tags
}
