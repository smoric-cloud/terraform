terraform {
  required_providers {
    kubernetes = {
      source = "hashicorp/kubernetes"
    }
  }
}

resource "kubernetes_deployment" "application" {
  metadata {
    name = var.application_name
    labels = {
      App = var.application_label
    }
  }

  spec {
    replicas = var.application_replica_count
    selector {
      match_labels = {
        App = var.application_label
      }
    }
    template {
      metadata {
        labels = {
          App = var.application_label
        }
      }
      spec {
        container {
          image = var.container_image
          name  = var.container_name

          port {
            container_port = var.container_port
          }

          resources {
            limits {
              cpu    = "0.5"
              memory = "512Mi"
            }
            requests {
              cpu    = "250m"
              memory = "50Mi"
            }
          }
        }
      }
    }
  }
}

resource "kubernetes_service" "application" {
  metadata {
    name = var.application_name
  }
  spec {
    selector = {
      App = var.application_label
    }
    port {
      port        = var.container_port
      target_port = var.container_port
    }

    type = "LoadBalancer"
  }
}

