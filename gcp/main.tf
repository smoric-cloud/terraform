terraform {
  required_version = ">= 0.12"
}

terraform {
  required_providers {
    google = {
      source = "hashicorp/google"
    }
    kubernetes = {
      source = "hashicorp/kubernetes"
    }
  }
}

provider "google" {
  project = var.project_id
  region  = var.region
}

module "network" {
  source = "./modules/network"
  project_id = var.project_id
  region  = var.region  
}

module "compute_engines" {
  source = "./modules/compute_engines"
  project_id = var.project_id
  region  = var.region
  zone = var.zone
  vpc_name=module.network.vpc_name
  vpc_subnet_name=module.network.vpc_subnet_name
}


/*provider "kubernetes" {
  load_config_file = false
  host     = module.kubernetes_cluster.kubernetes_cluster_host
  username = module.kubernetes_cluster.kubernetes_cluster_username
  password = module.kubernetes_cluster.kubernetes_cluster_password
  insecure=true
}

module "kubernetes_cluster" {
  source = "./modules/kubernetes_cluster"
  project_id = var.project_id
  region  = var.region
  zone = var.zone
  vpc_name=module.network.vpc_name
  vpc_subnet_name=module.network.vpc_subnet_name
}

module "kubernetes_applications" {
  source = "./modules/kubernetes_applications"
  for_each = var.kubernetes_applications
  kubernetes_cluster_host = module.kubernetes_cluster.kubernetes_cluster_host
  kubernetes_cluster_username = module.kubernetes_cluster.kubernetes_cluster_username
  kubernetes_cluster_password = module.kubernetes_cluster.kubernetes_cluster_password
  application_name  = each.value.application_name
  application_label = each.value.application_label
  application_replica_count = each.value.application_replica_count
  container_image= each.value.container_image
  container_name = each.value.container_name 
  container_port= each.value.container_port
  providers = {
    kubernetes=kubernetes
  }
}

*/