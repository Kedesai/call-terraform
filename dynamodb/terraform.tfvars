aws_region = "us-east-1"

table_name  = "ketan-terraform-gitops-test"
environment = "dev"

billing_mode = "PAY_PER_REQUEST"

hash_key      = "id"
hash_key_type = "S"

point_in_time_recovery = true

stream_enabled = false

deletion_protection_enabled = false

tags = {
  Application = "terraform-gitops-test"
  Environment = "dev"
  Owner       = "ketan"
}
