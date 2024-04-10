terraform {
  required_providers {
    google = {
      source  = "hashicorp/google"
      version = "5.18.0"
    }
  }

  backend "gcs" {
    bucket = "nodeshift-tf-state"
    prefix = "terraform/state"
  }
}

provider "google" {
  project = "dws-inc"
  region  = "us-central1"
}
