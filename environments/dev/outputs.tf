output "zone" {
  value = "${var.zone}"
}

output "project" {
  value = "${var.project}"
}
output "cluster_ca_certificate" {
  value = nonsensitive("${module.cluster.cluster_ca_certificate}")
}
output "cluster_name" {
  value = "${module.cluster.cluster_name}"
}
output "cluster_host" {
  value = "${module.cluster.cluster_host}"
}
output "nodepool_service_account" {
  value = nonsensitive("${module.cluster.nodepool_service_account}")
}