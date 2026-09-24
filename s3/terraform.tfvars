aws_region = "us-east-1"

bucket_name = "ketan-terraform-gitops-test-791970555359"
environment = "dev"

versioning_enabled = true

enable_encryption = true
sse_algorithm     = "AES256"

block_public_acls       = true
block_public_policy     = true
ignore_public_acls      = true
restrict_public_buckets = true

enable_lifecycle_rules = false

force_destroy = false

tags = {
  Application = "terraform-gitops-test"
  Environment = "dev"
  Owner       = "ketan"
}
