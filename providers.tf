terraform {
  required_providers {
    google = {
      source = "hashicorp/google"
      version = "3.85.0"
    }
  }
}

provider "google" {
  # Configuration options
  project = "my-terraform-project-426311"
  region = "us-central1"
  zone = "us-central1-a"
  credentials = "keys.json"
}

