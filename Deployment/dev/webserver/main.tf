module "my_ec2" {
  source = "git::https://github.com/ketandesai/Terraform.git//ec2?ref=main"
  instance_name = "manual-test-vm"
  environment   = "dev"

  tags = {
    Application = "webserver"
    Project     = "manual-setup"
    Environment = "dev"
    ManagedBy   = "manual"
    Owner       = "ketandesai"
    email       = "ketandesai@yahoo.com"
  }
}
