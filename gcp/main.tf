terraform {
  required_version = ">= 0.12"
}

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

module "network" {
  source = "./modules/network"
  project_id = var.project_id
  region  = var.region
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
  kubernetes_cluster_host = module.kubernetes_cluster.kubernetes_cluster_host
  kubernetes_cluster_username = module.kubernetes_cluster.kubernetes_cluster_username
  kubernetes_cluster_password = module.kubernetes_cluster.kubernetes_cluster_password
  application_name  = "nginix-sample"
  application_label = "nginix.sample"
  application_replica_count =2
  container_image="nginx:1.7.8"
  container_name = "nginix-sample"
  container_port=80
}

