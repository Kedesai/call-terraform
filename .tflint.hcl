plugin "aws" {
    enabled = true
    version = "0.21.0"
    source  = "github.com/terraform-linters/tflint-ruleset-aws"
}

rule "aws_resource_missing_tags" {
  enabled = true
  tags = [
    "Application",
    "Project",
    "Environment",
    "ManagedBy",
    "Owner"
  ]
}