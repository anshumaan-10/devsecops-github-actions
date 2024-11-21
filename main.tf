provider "google" {
  project     = "avian-voice-433417-d5"
  region      = "us-central1"
  zone        = "asia-southeast1-a"  # Use the same zone here
  credentials = "keys.json"  # Pass this securely in GitHub Actions
}

resource "google_compute_instance" "vm-from-tf" {
  name           = "vm-from-tf"
  zone           = "asia-southeast1-a"
  machine_type   = "n1-standard-1"
  allow_stopping_for_update = true

  network_interface {
    network    = "default"
    subnetwork = "default"
  }

  boot_disk {
    initialize_params {
      image = "debian-9-stretch-v20210916"
      size  = 35
    }
    auto_delete = false
  }

  labels = {
    "env" = "tflearning"
  }

  scheduling {
    preemptible       = false
    automatic_restart = false
  }

  service_account {
    email  = "815278883793-compute@developer.gserviceaccount.com"
    scopes = ["cloud-platform"]
  }

  lifecycle {
    ignore_changes = [
      boot_disk,
      network_interface
    ]
  }

  attached_disk {
    source      = google_compute_disk.disk-1.id
    device_name = "disk-1"
  }
}

resource "google_compute_disk" "disk-1" {
  name   = "disk-1"
  size   = 15
  zone   = "asia-southeast1-a"
  type   = "pd-ssd"
}

terraform {
  required_providers {
    google = {
      source  = "hashicorp/google"
      version = "3.85.0"
    }
  }
}
