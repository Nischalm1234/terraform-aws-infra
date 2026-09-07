terraform {
  required_version = ">= 1.0"

  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0"
    }
  }

  # This connects to the remote state resources you just built
  backend "s3" {
    bucket         = "terraform-state-nischal-2024" # Ensure this matches your exact bucket name
    key            = "aws-infra/terraform.tfstate"
    region         = "us-east-1"
    dynamodb_table = "terraform-state-lock"
    encrypt        = true
  }
}

provider "aws" {
  region = var.aws_region
}