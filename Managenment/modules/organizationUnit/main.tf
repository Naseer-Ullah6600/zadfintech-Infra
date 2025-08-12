

resource "aws_organizations_organizational_unit" "organization_unit" {
  for_each  = toset(var.organizational_units)
  name      = each.value
  parent_id = var.root_id
}
