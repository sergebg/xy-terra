provider "google" {
  version = "~> 2.0"
  project = var.project
  region  = var.region
}

resource "google_compute_network" "xy-network-1" {
  name                    = "${var.prefix}-vpc-${var.region}"
  auto_create_subnetworks = false
}

