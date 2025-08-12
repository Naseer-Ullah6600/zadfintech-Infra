resource "aws_organizations_account" "account" {
  for_each = {
    for account in var.accounts :
    "${account.parent_ou}-${account.name}" => account
  }

  name      = each.value.name
  email     = each.value.email
  parent_id = var.organizational_units[each.value.parent_ou]
  role_name = "OrganizationAccountAccessRole"
  tags      = each.value.tags

  depends_on = [
    var.organizational_units
  ]
}
