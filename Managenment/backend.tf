terraform {
  backend "s3" {
    bucket  = "canbolatter-terraform-state"
    key     = "management/terraform.tfstate"
    region  = "us-east-1"
    encrypt = true
  }
}
