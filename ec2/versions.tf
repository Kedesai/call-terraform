terraform {
  cloud {
    organization = "Ketan-Terraform-Orgainization"
    workspaces {
      name = "call-terraform"
    }
  }

  required_version = ">= 1.0.0"
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = ">= 5.0"
    }
  }
}
