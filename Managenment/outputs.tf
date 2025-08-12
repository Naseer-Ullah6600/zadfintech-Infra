# output "accounts_id" {
#   value = module.accounts.accounts_id
# }

# output "ou_ids" {
#   value = module.organizationUnit.ou_ids
# }


output "org_id" {
  value = data.aws_organizations_organization.existing_org.id
}

output "sso_enabled" {
  description = "Whether IAM Identity Center is enabled"
  value       = module.sso.sso_enabled
}

output "sso_instance_arn" {
  description = "The ARN of the SSO instance (empty if not enabled)"
  value       = module.sso.sso_instance_arn
}

output "sso_identity_store_id" {
  description = "The identity store ID of the SSO instance (empty if not enabled)"
  value       = module.sso.sso_identity_store_id
}
