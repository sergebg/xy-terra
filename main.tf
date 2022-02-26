provider "google" {
  project = var.project
  region  = var.region
}

resource "google_compute_network" "net1" {
  name                    = "${var.prefix}-vpc-${var.region}"
  auto_create_subnetworks = false
}

resource "google_compute_subnetwork" "subnet1" {
  name          = "${var.prefix}-subnetwork-${var.region}"
  region        = var.region
  network       = google_compute_network.net1.self_link
  ip_cidr_range = "10.0.10.0/24"
}

resource "google_compute_instance" "vm_chicago" {
  name         = "chicago"
  zone         = var.zone
  machine_type = "f1-micro"

  boot_disk {
    initialize_params {
      image = "debian-cloud/debian-10"
      size  = 10
      type  = "pd-standard"
    }
    device_name = "chicago_disk"
    auto_delete = true
  }

  network_interface {
    network    = google_compute_network.net1.name
    subnetwork = google_compute_subnetwork.subnet1.name
    access_config {
    }
  }

  scheduling {
    preemptible         = true
    automatic_restart   = false
    on_host_maintenance = "TERMINATE"
  }

  allow_stopping_for_update = true
  description               = "Chicago VM"
}