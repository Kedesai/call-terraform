aws_region = "us-east-2"

instance_name = "ketan-test-ec2"
environment   = "dev"


instance_type = "t3a.small"

subnet_id = "subnet-0f488043a31321b72"

vpc_security_group_ids = [
  "sg-09d996e9e924d8bce"
]

root_volume_size = 20
root_volume_type = "gp3"

tags = {
  Application = "terraform-test"
  Environment = "dev"
  Owner       = "ketan"
  Region      = "us-east-1"
}
