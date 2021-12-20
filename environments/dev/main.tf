locals {
  env = "dev"
}

provider "google" {
  project       = "${var.project}"
  credentials   = file("${var.gcp_service_account_key}")
  region        = "${var.region}"
}

module "cluster" {
  source  = "../../modules/gcp/cluster"
  # all following vars can be overwritten
  # Note: Use either a predefined machine type such as n1-standard-1,
  # or custom-<cpus>-<memory_mb>(-ext) (use this format to specify extended memory (XL cluster))
  project = "${var.project}"
  env = "${local.env}"
  region = "${var.region}"
  zone = "${var.zone}"
  cluster_name = "${var.cluster_name}"
  node_type = "${var.node_type}"
  node_disk_size_gb = "${var.node_disk_size_gb}"
  node_disk_type = "${var.node_disk_type}"
  number_of_nodes = "${var.number_of_nodes}"
}
