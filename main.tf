provider "google" {
  version = "~> 2.0"
  project = var.project
  region  = var.region
}

resource "google_compute_network" "hashicat" {
  name                    = "${var.prefix}-vpc-${var.region}"
  auto_create_subnetworks = false
}

