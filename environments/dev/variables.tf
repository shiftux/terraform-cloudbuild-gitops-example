variable "project" {
  type        = string
  description = "GCP project in which to allocate resources. Defined in tfvars"
}

variable "gcp_service_account_key" {
  type        = string
  description = "GCP service account key relative path location (to the json file). Defined in tfvars"
}

variable "region" {
  type        = string
  default     = "europe-west6"
  description = "Compute region in which to allocate resources."
}

variable "zone" {
  type        = string
  default     = "europe-west6-a"
  description = "Compute zone in which to allocate resources."
}

variable "cluster_name" {
  type        = string
  default     = "dev-k8s-cluster"
  description = "Name of the provisioned cluster."
}

variable "node_type" {
  type        = string
  default     = "n1-standard-1"
  description = "GCP machine type to be used for the cluster. The type specifies CPU and available memory. Please see https://cloud.google.com/compute/docs/machine-types#predefined_machine_types for a list of available types."
}

variable "node_disk_size_gb" {
  type        = number
  description = "Disk size of local machine storage."
  default     = 20
}

variable "node_disk_type" {
  type        = string
  default     = "pd-standard"
  description = "Type of the disk attached to each node (pd-standard or pd-ssd)."
}

variable "number_of_nodes" {
  type        = number
  default     = 2
  description = "Number of nodes in the cluster."
}