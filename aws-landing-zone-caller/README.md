# AWS Landing Zone Caller v2

Environment-specific caller for the sibling reusable repository.

Expected local layout:

```text
aws-landing-zone-v2/
├── aws-landing-zone-reusable/
└── aws-landing-zone-caller/
```

The local module source is `../aws-landing-zone-reusable/foundation`. For separate Git repositories/HCP Terraform, replace it with your Git or registry source.

Copy `terraform.tfvars.example` to `terraform.tfvars` and replace all example account email addresses before applying.
