output "accounts_id" {
  value = { for acc in aws_organizations_account.account : acc.name => acc.id }
}