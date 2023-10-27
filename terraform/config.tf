// Configurações globais para o Terraform
terraform {
  required_version = ">=1.1.0"
  required_providers {
    aws = {
      source = "hashicorp/aws"
      version = "5.22.0"
    }
  }
}

// Declaração do provider AWS
provider "aws" {
  profile = "desafio"   # Define o perfil que contém usuário e senha de acesso na aws
  region = "us-east-1"  # Define a Região
  
  default_tags {
    tags = {
      managed-by = "terraform" # Tag default para todos os serviços terraform
    }
    
  }
}