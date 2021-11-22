terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 3.0"
    }
  }
}

# Configure the AWS Provider
provider "aws" {
  region = "us-east-1"
}

module "octopus-terraform-test" {
  source = "./modules/aws-octopus-ci-role-group-user-policy"

  ci_name = "octopus"
}