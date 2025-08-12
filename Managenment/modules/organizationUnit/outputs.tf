output "aws_organizations_organizational_unit" {
  value = aws_organizations_organizational_unit.organization_unit
}

output "ou_ids" {
  description = "Map of OU name to IDs"
  value       = { for ou in aws_organizations_organizational_unit.organization_unit : ou.name => ou.id }
}