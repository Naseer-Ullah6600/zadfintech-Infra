variable "environment" {
  type = string
  description = "The environment to deploy the resources to"
}

variable "region" {
  type = string
  description = "The region to deploy the resources to"
}

variable "tags" {
  type = map(string)
  description = "The tags to deploy the resources to"
  default = {
    "Project" = "zadfintech"
    "CreatedBy" = "Terraform"
  }
}
