provider "aws" {
  region = "ap-south-1"
   access_key = "AKIAYJGJZLGGGKL2Z6VI"
  secret_key = "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"
}


terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 3.37.0"
    }
  }
}
