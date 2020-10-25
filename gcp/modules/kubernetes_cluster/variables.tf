variable "project_id" {
  description = "GCP project id"
}

variable "region" {
  description = "GCP region id"
}

variable "zone" {
  description = "GCP zone id"
}


variable "vpc_name" {
  description = "VPC name"
}

variable "vpc_subnet_name" {
  description = "VPC subnet name"
}


variable "gke_username" {
  default     = "MASTER"
  description = "gke username"
}

variable "gke_password" {
  default     = "MASTER1234567890"
  description = "gke password"
}

variable "gke_num_nodes" {
  default     = 3
  description = "number of gke nodes"
}
