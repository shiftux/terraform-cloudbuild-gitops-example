resource "google_service_account" "k8s_service_account" {
  account_id   = "${var.project}-${var.env}-k8s-sa"
  display_name = "${var.project}-${var.env} k8s service account"
  project = "${var.project}"
}

resource "google_container_cluster" "primary" {
  name     = "${var.cluster_name}"
  location = "${var.zone}"

  logging_config {
    enable_components = ["SYSTEM_COMPONENTS", "WORKLOADS"]
  }
  monitoring_config {
    enable_components = ["SYSTEM_COMPONENTS"] # "WORKLOADS" is beta... can be enabled via gcloud
  }
  # Impossible to create a cluster with no node pool defined, but we want to only use
  # separately managed node pools. So we create the smallest possible default
  # node pool and immediately delete it.
  remove_default_node_pool = true
  initial_node_count       = 1
  # logging_service    = "logging.googleapis.com/kubernetes"
  # monitoring_service = "monitoring.googleapis.com/kubernetes"
}

resource "google_container_node_pool" "primary_preemptible_nodes" {
  name       = "${var.cluster_name}-node-pool"
  location   = "${var.zone}"
  cluster    = google_container_cluster.primary.name
  node_count = "${var.number_of_nodes}"

  node_config {
    preemptible  = true  # VMs will be destroyed after 24h
    machine_type = "${var.node_type}"
    disk_size_gb = "${var.node_disk_size_gb}"
    disk_type    = "${var.node_disk_type}"

    # Google recommends custom service accounts that have cloud-platform scope and permissions granted via IAM Roles.
    service_account = google_service_account.k8s_service_account.email
    oauth_scopes    = [
      "https://www.googleapis.com/auth/cloud-platform",
      "https://www.googleapis.com/auth/monitoring",
      "https://www.googleapis.com/auth/devstorage.read_only", # required to fetch images from gcr.io
      "https://www.googleapis.com/auth/logging.write",
      "https://www.googleapis.com/auth/cloud_debugger" # required for cloud debugger
    ]
  }
}

# allow access to container registry
resource "google_project_iam_member" "project" {
  project = "${var.project}"
  role    = "roles/storage.objectViewer"
  member  = "serviceAccount:${google_container_node_pool.primary_preemptible_nodes.node_config[0].service_account}"
}
