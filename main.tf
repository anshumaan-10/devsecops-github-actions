# Define a Google Compute Engine instance named "vm-from-tf"
resource "google_compute_instance" "vm-from-tf" {
  name = "vm-from-tf"
  zone = "asia-southeast1-a"
  machine_type = "n1-standard-1"

  allow_stopping_for_update = true

  # Define network interface settings
  network_interface {
    network = "default"
    subnetwork = "default"
  }

  # Define boot disk settings
  boot_disk {
    initialize_params {
      image = "debian-9-stretch-v20210916"  # Debian 9 Stretch image
      size = 35  # Disk size: 35 GB
    }
    auto_delete = false
  }

  # Define labels for the instance
  labels = {
    "env" = "tflearning"  # Environment label: "tfleaning"
  }

  # Define scheduling parameters
  scheduling {
    preemptible = false  # Not preemptible
    automatic_restart = false  # Do not automatically restart
  }
  
  # Define service account settings
  service_account {
    email = "815278883793-compute@developer.gserviceaccount.com"
    scopes = [ "cloud-platform" ]  # Cloud Platform scope
  }

  # Define lifecycle configuration to ignore changes to attached disks
  lifecycle {
    ignore_changes = [
      attached_disk
    ]
  }
}

# Define a Google Compute Engine disk named "disk-1"
resource "google_compute_disk" "disk-1" {
  name = "disk-1"
  size = 15  # Disk size: 15 GB
  zone = "asia-southeast1-a"
  type = "pd-ssd"  # Disk type: SSD
}

# Attach the disk to the instance
resource "google_compute_attached_disk" "adisk" {
  disk = google_compute_disk.disk-1.id  # Attach disk-1
  instance = google_compute_instance.vm-from-tf.id  # to the vm-from-tf instance
}
