terraform {
  backend "s3" {
    bucket  = "canbolatter-infra-state"
    key     = "dev/terraform.tfstate"
    region  = "eu-west-3"
    encrypt = true
  }
}
