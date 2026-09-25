provider "aws" {
  region = var.region
}

module "eks" {
  source = "git::https://github.com/Kedesai/terraform.git//eks?ref=main"

  region          = var.region
  cluster_name    = var.cluster_name
  cluster_version = var.cluster_version

  subnet_ids = var.subnet_ids

  cluster_role_arn = var.cluster_role_arn
  node_role_arn    = var.node_role_arn

  enable_irsa                  = var.enable_irsa
  enable_cluster_creator_admin = var.enable_cluster_creator_admin

  node_groups = var.node_groups

  pipeline_name = var.pipeline_name
  run_id        = var.run_id
  created_by    = var.created_by

  tags = var.tags
}
