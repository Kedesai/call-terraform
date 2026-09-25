provider "aws" {
  region = var.aws_region
}

data "aws_iam_policy_document" "ec2_assume_role" {
  statement {
    effect = "Allow"

    actions = [
      "sts:AssumeRole"
    ]

    principals {
      type = "Service"

      identifiers = [
        "ec2.amazonaws.com"
      ]
    }
  }
}

module "iam" {
  source = "git::https://github.com/Kedesai/terraform.git//iam?ref=main"

  role_name   = var.role_name
  environment = var.environment
  description = var.description

  assume_role_policy = data.aws_iam_policy_document.ec2_assume_role.json

  max_session_duration = var.max_session_duration

  permissions_boundary = null

  managed_policy_arns = var.managed_policy_arns
  inline_policies     = var.inline_policies

  create_instance_profile = var.create_instance_profile

  tags = var.tags
}
