# Terraform Block
terraform {
  required_version = ">= 1.1.0" 
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = ">= 5.0"
    }
    null = {
      source = "hashicorp/null"
      version = "~> 3.0"
    }    
              
  }
}

# Provider Block
provider "aws" {
  region  = var.aws_region
  
}