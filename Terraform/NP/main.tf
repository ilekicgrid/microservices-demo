# Authenticate with GCP
provider "google" {
  project     = "gd-gcp-gridu-devops-t1-t2"
  region      = "us-central1"
}

# Create a GKE cluster with zero initial nodes
#resource "google_container_cluster" "vdjurovic_cluster_np" {
#  name     = "vdjurovic-cluster-np"
#  location = "us-central1"
#  deletion_protection = false
#  initial_node_count = 1
#  #remove_default_node_pool = true
#}
#resource "google_storage_bucket" "terraform_state_np" {
#  name          = "viv_bucket_np"
#  location      = "US"
#  force_destroy = true
#
#  versioning {
#    enabled = true
#  }
#}



