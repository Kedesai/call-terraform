aws_region = "us-east-1"

alb_name    = "ketan-terraform-alb-test"
environment = "dev"

internal        = true
ip_address_type = "ipv4"

subnets = [
  "subnet-0ef6e2bfb64babf65",
  "subnet-0f488043a31321b72"
]

security_groups = [
  "sg-09d996e9e924d8bce"
]

enable_deletion_protection = false
enable_http2               = true

target_groups = []
listeners     = []

tags = {
  Application = "terraform-gitops-test"
  Environment = "dev"
  Owner       = "ketan"
}
