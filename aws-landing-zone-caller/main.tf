module "landing_zone" {
  source = "../aws-landing-zone-reusable/foundation"
  feature_set                   = var.feature_set
  enabled_policy_types          = var.enabled_policy_types
  aws_service_access_principals = var.aws_service_access_principals
  organizational_units          = var.organizational_units
  accounts                      = var.accounts
  service_control_policies      = var.service_control_policies
  scp_attachments               = var.scp_attachments
}
