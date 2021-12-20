output "cluster_ca_certificate" {
  value = base64decode(
    google_container_cluster.primary.master_auth[0].cluster_ca_certificate,
  )
  sensitive = true
  description = "CA certificate of Kubernetes cluster."
}

output "cluster_name" {
  value       = google_container_cluster.primary.name
}

output "cluster_host" {
  value       = "https://${google_container_cluster.primary.endpoint}"
  description = "API endpoint of Kubernetes master."
}

output "cluster_username" {
  value     = google_container_cluster.primary.master_auth[0].username
  sensitive = true
}

output "cluster_password" {
  value     = google_container_cluster.primary.master_auth[0].password
  sensitive = true
}

output "nodepool_service_account" {
  value     = google_container_node_pool.primary_preemptible_nodes.node_config[0].service_account
  sensitive = true
}
