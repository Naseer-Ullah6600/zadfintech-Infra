# variable "development_ou_id" {
#   type = string
# }

variable "active_accounts" {
  description = "List of AWS account IDs where SSO should be enabled"
  type        = list(string)
  default     = []
}