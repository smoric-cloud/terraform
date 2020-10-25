output "kubernetes_cluster_host" {
  value       = google_container_cluster.primary.endpoint
  description = "GKE Cluster Host"
}

output "kubernetes_cluster_username" {
  value       = var.gke_username
  description = "GKE Cluster User Name"
}

output "kubernetes_cluster_password" {
  value       = var.gke_password
  description = "GKE Cluster User Password"
}
