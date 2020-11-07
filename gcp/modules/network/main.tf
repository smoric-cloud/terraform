terraform {
  required_providers {
    google = {
      source = "hashicorp/google"
    }
  }
}

provider "google" {
  project = var.project_id
  region  = var.region
}

resource "google_compute_network" "vpc" {
  name                    = "${var.project_id}-vpc"
  auto_create_subnetworks = "false"
}

resource "google_compute_subnetwork" "subnet" {
  name          = "${var.project_id}-subnet"
  region        = var.region
  network       = google_compute_network.vpc.name
  ip_cidr_range = "10.10.0.0/24"
}

resource "google_compute_firewall" "vpc" {
  name    = "vpc-firewall"
  network = google_compute_network.vpc.name

  allow {
    protocol = "icmp"
  }

  allow {
    protocol = "tcp"
    ports    = ["80", "8080","22"]
  }

}


resource "google_dns_managed_zone" "zone" {
  name        = "${var.project_id}-zone"
  dns_name    = "morro.services.com."
  
  visibility = "private"

  private_visibility_config {
    networks {
      network_url = google_compute_network.vpc.id
    }   
  }
}


