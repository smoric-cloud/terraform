output "vpc_name" {
  value       = google_compute_network.vpc.name
  description = "VPC Net Name"
}

output "vpc_subnet_name" {
  value       = google_compute_subnetwork.subnet.name
  description = "VPC SubNet Name"
}