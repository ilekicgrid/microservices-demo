# Authenticate with GCP
provider "google" {
  credentials = file("/Users/vdjurovic/Downloads/GCP_Keys/gd-gcp-gridu-devops-t1-t2-8f6b8b5512c0.json")
  project     = "gd-gcp-gridu-devops-t1-t2"
  region      = "us-central1"
}

# Create a GKE cluster with zero initial nodes
resource "google_container_cluster" "vdjurovic_cluster" {
  name     = "vdjurovic-cluster"
  location = "us-central1"
  deletion_protection = false
  initial_node_count = 1
  cluster_autoscaling {
    enabled = false
  }
  #remove_default_node_pool = true
}

