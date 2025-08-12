provider "aws" {
  region = "us-east-1"
}

data "aws_organizations_organization" "existing_org" {}

# module "organizationUnit" {
#   source               = "./modules/organizationUnit"
#   organizational_units = ["dev_staging"] #, "prod" , "security"
#   root_id              = data.aws_organizations_organization.existing_org.roots[0].id
# }

# module "accounts" {
#   source               = "./modules/accounts"
#   organizational_units = module.organizationUnit.ou_ids
#   accounts = [
#     {
#       name      = "development"
#       email     = "development@example.com"
#       parent_ou = "dev_staging"
#       tags      = { Environment = "Dev_staging", Name = "Development" }
#     }
#     # {
#     #   name      = "staging"
#     #   email     = "staging@example.com"
#     #   parent_ou = "dev_staging"
#     #   tags      = { Environment = "Dev_staging" , Name = "Staging" }
#     # },
#     #  {
#     #   name      = "Production"
#     #   email     = "production@example.com"
#     #   parent_ou = "prod"
#     #   tags      = { Environment = "Production" , Name = "Production" }
#     # },
#     # {
#     #   name      = "audit"
#     #   email     = "audit@example.com"
#     #   parent_ou = "security"
#     #   tags      = { Environment = "Audit" , Name = "Audit" }
#     # },
#     # {
#     #   name      = "log"
#     #   email     = "log@example.com"
#     #   parent_ou = "security"
#     #   tags      = { Environment = "Log" , Name = "Log" }
#     # }
#   ]
# }

module "sso" {
  source          = "./modules/sso"
  active_accounts = ["014030150535"]
}