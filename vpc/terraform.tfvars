aws_region  = "us-east-1"
environment = "dev"

create_vpc = false

existing_vpc_id = "vpc-0df35472004c2a07d"

existing_private_subnet_ids = [
  "subnet-0ef6e2bfb64babf65",
  "subnet-0f488043a31321b72"
]

existing_public_subnet_ids = []

enable_nat_gateway = false
enable_flow_logs   = false

tags = {
  Application = "terraform-gitops-test"
  Environment = "dev"
  Owner       = "ketan"
}
