terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "5.5.0"
    }
  }
}

provider "aws" {
  profile = "youraws_profile_access_secret_keys"
  region  = "us-east-1"
}
