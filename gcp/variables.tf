variable "project_id" {
  description = "GCP project id"
}

variable "region" {
  description = "GCP region id"
}

variable "zone" {
  description = "GCP zone id"
}

variable "kubernetes_applications" {
  type = map
  default = {
    app_1 = {
      application_name  = "nginix-sample-1"
      application_label = "nginix.sample_1"
      application_replica_count =2
      container_image="nginx:1.7.8"
      container_name = "nginix-sample-1"
      container_port=80
    },
    app2 = {
      application_name  = "nginix-sample-2"
      application_label = "nginix.sample_2"
      application_replica_count =2
      container_image="nginx:1.7.8"
      container_name = "nginix-sample-2"
      container_port=80
    }    
  }
}