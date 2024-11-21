terraform {
  required_providers {
    google = {
      source  = "hashicorp/google"
      version = "3.85.0"
    }
  }
}

provider "google" {
  project = "avian-voice-433417-d5"
  region  = "us-central1"
  zone    = "asia-southeast1-a"
}
