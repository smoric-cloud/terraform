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

resource "google_compute_instance" "provisioning-master" {
  name         = "provisioning-master"
  machine_type = "n1-standard-1"
  zone         = var.zone
  allow_stopping_for_update = true

  boot_disk {
    initialize_params {
      image = "ubuntu-1604-xenial-v20201014"
    }
  }

  network_interface {
    network = var.vpc_name
    subnetwork  = var.vpc_subnet_name
    access_config {
    }
  }

  metadata_startup_script = file("${path.module}/scripts/ansimble-install.sh")
}

resource "google_compute_instance" "jenkins-server" {
  name         = "jenkins-server"
  machine_type = "n1-standard-1"
  zone         = var.zone
  allow_stopping_for_update = true

  boot_disk {
    initialize_params {
      image = "ubuntu-1604-xenial-v20201014"
    }
  }

  network_interface {
    network = var.vpc_name
    subnetwork  = var.vpc_subnet_name
    access_config {
    }
  }
}
