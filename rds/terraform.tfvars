aws_region = "us-east-1"

db_instance_identifier = "ketan-terraform-rds-test"
environment            = "dev"

engine         = "postgres"
engine_version = "15.4"
instance_class = "db.t3.micro"

allocated_storage     = 20
max_allocated_storage = 0
storage_type          = "gp3"

db_name = "ketandb"

db_subnet_group_name        = "ketan-rds-dev-subnet-group"
db_subnet_group_description = "Terraform GitOps RDS development subnet group"

db_subnet_ids = [
  "subnet-0ef6e2bfb64babf65",
  "subnet-0f488043a31321b72"
]

vpc_security_group_ids = [
  "sg-09d996e9e924d8bce"
]

multi_az                = false
backup_retention_period = 7

performance_insights_enabled = false

skip_final_snapshot = true
deletion_protection = false

apply_immediately = false

tags = {
  Application = "terraform-gitops-test"
  Environment = "dev"
  Owner       = "ketan"
}
