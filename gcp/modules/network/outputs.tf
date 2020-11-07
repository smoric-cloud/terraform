output "vpc_name" {
  value       = google_compute_network.vpc.name
  description = "VPC Net Name"
}

output "vpc_subnet_name" {
  value       = google_compute_subnetwork.subnet.name
  description = "VPC SubNet Name"
}

output "vpc_zone_name" {
  value       = google_dns_managed_zone.zone.name
  description = "VPC DNS Zone Name"
}

output "vpc_zone_dns_name" {
  value       = google_dns_managed_zone.zone.dns_name
  description = "VPC DNS Zone Name"
}