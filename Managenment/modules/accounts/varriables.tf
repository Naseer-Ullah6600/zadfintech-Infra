variable "accounts" {
  type = list(object({
    name      = string
    email     = string
    parent_ou = string
    tags      = map(string)
  }))
}

variable "organizational_units" {
  type = map(string)
}