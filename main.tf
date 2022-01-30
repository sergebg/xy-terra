provider "google" {
  project = var.project
  region  = var.region
}

resource "google_compute_network" "net1" {
  name                    = "${var.prefix}-vpc-${var.region}"
  auto_create_subnetworks = false
}

resource "google_compute_subnetwork" "subnet1" {
  name = ${var.prefix}-subnetwork-${var.region}
  region = var.region
  network = google_compute_network.net1.self_link
  ip_cidr_range = "10.0.10.0/24"
}
