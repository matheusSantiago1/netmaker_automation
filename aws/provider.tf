provider "aws" {
  region = "ca-central-1"

  default_tags {
    tags = {
      "Project"     = var.project
      "Environment" = terraform.workspace
      "Terraform"   = "true"
    }
  }
}

provider "tls" {
  # Configuration options
}