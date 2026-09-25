region = "us-east-1"

cluster_name    = "ketan-eks-dev"
cluster_version = "1.34"

subnet_ids = [
  "subnet-0ef6e2bfb64babf65",
  "subnet-0f488043a31321b72"
]

enable_irsa                  = false
enable_cluster_creator_admin = true

node_groups = {
  general = {
    instance_types = ["t3a.small"]
    desired_size   = 1
    min_size       = 1
    max_size       = 2
    capacity_type  = "ON_DEMAND"
  }
}

pipeline_name = "hcp-terraform"
run_id        = "manual"
created_by    = "ketan"

tags = {
  Application = "terraform-gitops-test"
  Environment = "dev"
  Owner       = "ketan"
}
