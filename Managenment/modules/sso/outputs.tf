output "sso_instance_arn" {
  description = "The ARN of the SSO instance"
  value       = length(data.aws_ssoadmin_instances.current.arns) > 0 ? data.aws_ssoadmin_instances.current.arns[0] : ""
}

output "sso_identity_store_id" {
  description = "The identity store ID of the SSO instance"
  value       = length(data.aws_ssoadmin_instances.current.identity_store_ids) > 0 ? data.aws_ssoadmin_instances.current.identity_store_ids[0] : ""
}

output "permission_set_arns" {
  description = "ARNs of the created permission sets"
  value = {
    administrator_access = length(aws_ssoadmin_permission_set.administrator_access) > 0 ? aws_ssoadmin_permission_set.administrator_access[0].arn : ""
    read_only_access     = length(aws_ssoadmin_permission_set.read_only_access) > 0 ? aws_ssoadmin_permission_set.read_only_access[0].arn : ""
    developers           = length(aws_ssoadmin_permission_set.developers) > 0 ? aws_ssoadmin_permission_set.developers[0].arn : ""
  }
}

output "group_ids" {
  description = "IDs of the created Identity Center groups"
  value = {
    administrators  = length(aws_identitystore_group.administrators) > 0 ? aws_identitystore_group.administrators[0].group_id : ""
    read_only_users = length(aws_identitystore_group.read_only_users) > 0 ? aws_identitystore_group.read_only_users[0].group_id : ""
    developers      = length(aws_identitystore_group.dev_user) > 0 ? aws_identitystore_group.dev_user[0].group_id : ""
  }
}

output "sso_enabled" {
  description = "Whether SSO instances exist (IAM Identity Center is enabled)"
  value       = length(data.aws_ssoadmin_instances.current.arns) > 0
}
