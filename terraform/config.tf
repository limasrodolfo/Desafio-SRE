terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "5.23.1"
    }
  }
}

provider "aws" {
  profile = "desafio"
  region  = "us-east-1"

  default_tags {
    tags = {
      managed-by = "terraform"
    }

  }
}