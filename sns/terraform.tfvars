aws_region = "us-east-1"

topic_name   = "ketan-terraform-gitops-test"
environment  = "dev"
display_name = "Terraform GitOps Test"

fifo_topic                  = false
content_based_deduplication = false

subscriptions = []

tags = {
  Application = "terraform-gitops-test"
  Environment = "dev"
  Owner       = "ketan"
}
