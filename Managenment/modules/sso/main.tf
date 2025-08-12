# Data source to get existing SSO instances
data "aws_ssoadmin_instances" "current" {}

locals {
  # Check if SSO instances exist, if not, create empty lists to prevent errors
  sso_instances_exist = length(data.aws_ssoadmin_instances.current.arns) > 0

  sso_instance_arn      = local.sso_instances_exist ? data.aws_ssoadmin_instances.current.arns[0] : ""
  sso_identity_store_id = local.sso_instances_exist ? data.aws_ssoadmin_instances.current.identity_store_ids[0] : ""

  active_accounts = var.active_accounts
}

# Create Identity Center groups
resource "aws_identitystore_group" "administrators" {
  count = local.sso_instances_exist ? 1 : 0

  identity_store_id = local.sso_identity_store_id
  display_name      = "Administrators"
  description       = "Group for administrators with full access"
}

resource "aws_identitystore_group" "read_only_users" {
  count = local.sso_instances_exist ? 1 : 0

  identity_store_id = local.sso_identity_store_id
  display_name      = "ReadOnlyUsers"
  description       = "Group for read-only users"
}

resource "aws_identitystore_group" "dev_user" {
  count = local.sso_instances_exist ? 1 : 0

  identity_store_id = local.sso_identity_store_id
  display_name      = "developers"
  description       = "Group for developers users with limited administrative access"
}

# Only create resources if SSO instances exist
resource "aws_ssoadmin_permission_set" "administrator_access" {
  count = local.sso_instances_exist ? 1 : 0

  name             = "AdministratorAccess"
  description      = "Provides full access to AWS services and resources"
  instance_arn     = local.sso_instance_arn
  session_duration = "PT8H" # 8 hours
}

resource "aws_ssoadmin_permission_set" "read_only_access" {
  count = local.sso_instances_exist ? 1 : 0

  name             = "ReadOnlyAccess"
  description      = "Provides read-only access to AWS services and resources"
  instance_arn     = local.sso_instance_arn
  session_duration = "PT8H" # 8 hours
}

resource "aws_ssoadmin_permission_set" "developers" {
  count = local.sso_instances_exist ? 1 : 0

  name             = "developers"
  description      = "Provides access to AWS services and resources, but does not allow management of Users and groups"
  instance_arn     = local.sso_instance_arn
  session_duration = "PT8H" # 8 hours
}

# Developer Permission Set with Secrets Manager Deny
resource "aws_ssoadmin_permission_set" "developer" {
  count = local.sso_instances_exist ? 1 : 0

  name             = "Developer"
  description      = "Provides full administrative access to all AWS services and resources, with an explicit deny on all actions within AWS Secrets Manager"
  instance_arn     = local.sso_instance_arn
  session_duration = "PT8H" # 8 hours
}

# Inline policy for Developer permission set
resource "aws_ssoadmin_permission_set_inline_policy" "developer_deny_secrets" {
  count = local.sso_instances_exist ? 1 : 0

  inline_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Effect   = "Deny"
        Action   = "secretsmanager:*"
        Resource = "*"
      }
    ]
  })
  instance_arn       = local.sso_instance_arn
  permission_set_arn = aws_ssoadmin_permission_set.developer[0].arn
}

# Attach managed policies to permission sets
resource "aws_ssoadmin_managed_policy_attachment" "administrator_access" {
  count = local.sso_instances_exist ? 1 : 0

  instance_arn       = local.sso_instance_arn
  permission_set_arn = aws_ssoadmin_permission_set.administrator_access[0].arn
  managed_policy_arn = "arn:aws:iam::aws:policy/AdministratorAccess"
}

resource "aws_ssoadmin_managed_policy_attachment" "read_only_access" {
  count = local.sso_instances_exist ? 1 : 0

  instance_arn       = local.sso_instance_arn
  permission_set_arn = aws_ssoadmin_permission_set.read_only_access[0].arn
  managed_policy_arn = "arn:aws:iam::aws:policy/ReadOnlyAccess"
}

resource "aws_ssoadmin_managed_policy_attachment" "developers" {
  count = local.sso_instances_exist ? 1 : 0

  instance_arn       = local.sso_instance_arn
  permission_set_arn = aws_ssoadmin_permission_set.developers[0].arn
  managed_policy_arn = "arn:aws:iam::aws:policy/developers"
}

resource "aws_ssoadmin_managed_policy_attachment" "developer_admin_access" {
  count = local.sso_instances_exist ? 1 : 0

  instance_arn       = local.sso_instance_arn
  permission_set_arn = aws_ssoadmin_permission_set.developer[0].arn
  managed_policy_arn = "arn:aws:iam::aws:policy/AdministratorAccess"
}

# Account assignments for each permission set
resource "aws_ssoadmin_account_assignment" "administrator_access" {
  count = local.sso_instances_exist ? length(local.active_accounts) : 0

  instance_arn       = local.sso_instance_arn
  permission_set_arn = aws_ssoadmin_permission_set.administrator_access[0].arn

  principal_id   = aws_identitystore_group.administrators[0].group_id
  principal_type = "GROUP"

  target_id   = local.active_accounts[count.index]
  target_type = "AWS_ACCOUNT"
}

resource "aws_ssoadmin_account_assignment" "read_only_access" {
  count = local.sso_instances_exist ? length(local.active_accounts) : 0

  instance_arn       = local.sso_instance_arn
  permission_set_arn = aws_ssoadmin_permission_set.read_only_access[0].arn

  principal_id   = aws_identitystore_group.read_only_users[0].group_id
  principal_type = "GROUP"

  target_id   = local.active_accounts[count.index]
  target_type = "AWS_ACCOUNT"
}

resource "aws_ssoadmin_account_assignment" "developers" {
  count = local.sso_instances_exist ? length(local.active_accounts) : 0

  instance_arn       = local.sso_instance_arn
  permission_set_arn = aws_ssoadmin_permission_set.developers[0].arn

  principal_id   = aws_identitystore_group.dev_user[0].group_id
  principal_type = "GROUP"

  target_id   = local.active_accounts[count.index]
  target_type = "AWS_ACCOUNT"
}

resource "aws_ssoadmin_account_assignment" "developer" {
  count = local.sso_instances_exist ? length(local.active_accounts) : 0

  instance_arn       = local.sso_instance_arn
  permission_set_arn = aws_ssoadmin_permission_set.developer[0].arn

  principal_id   = aws_identitystore_group.dev_user[0].group_id
  principal_type = "GROUP"

  target_id   = local.active_accounts[count.index]
  target_type = "AWS_ACCOUNT"
}
