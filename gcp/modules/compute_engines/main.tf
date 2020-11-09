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

  metadata_startup_script = file("${path.module}/install-scripts/provisioning-master-install.sh")
 
}

resource "google_dns_record_set" "provisioning-master" {
  name = "provisioning-master.${var.vpc_zone_dns_name}"
  type = "A"
  ttl  = 300

  managed_zone = var.vpc_zone_name

  rrdatas = [google_compute_instance.provisioning-master.network_interface[0].access_config[0].nat_ip]
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

resource "google_dns_record_set" "jenkins-server" {
  name = "jenkins-server.${var.vpc_zone_dns_name}"
  type = "A"
  ttl  = 300

  managed_zone = var.vpc_zone_name

  rrdatas = [google_compute_instance.jenkins-server.network_interface[0].access_config[0].nat_ip]
}
