terraform {
  backend "s3" {
    bucket         = "netmaker-terraform"
    key            = "terraform.tfstate"
    encrypt        = true
    region         = "ca-central-1"
    profile        = "my-profile"
  }

  required_providers {
    aws = {
      source  = "hashicorp/aws",
      version = "5.14.0"
    }

    local = {
      source  = "hashicorp/local"
      version = "2.4.0"
    }

    null = {
      source  = "hashicorp/null"
      version = "3.2.1"
    }
  }

  required_version = "1.5.5"
}
