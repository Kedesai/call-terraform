aws_region = "us-east-2"

instance_name = "ketan-test-ec2"
environment   = "dev"

instance_type = "t3.micro"

subnet_id = "subnet-xxxxxxxxxxxxxxxxx"

vpc_security_group_ids = [
  "sg-xxxxxxxxxxxxxxxxx"
]

root_volume_size = 20
root_volume_type = "gp3"

tags = {
  Application = "terraform-test"
  Environment = "dev"
  Owner       = "ketan"
}
