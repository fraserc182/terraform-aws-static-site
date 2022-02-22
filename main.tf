terraform {
  required_providers {
    aws = {
      source = "hashicorp/aws"
    }
  }
}

provider "aws" {
  region = "eu-west-1"
  default_tags {
    tags = {
      CreatedBy   = "fraser"
      Terraform   = "True"
    }
  }
}