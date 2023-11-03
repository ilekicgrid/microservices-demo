# Authenticate with GCP
provider "google" {
  #credentials = file("/Users/vdjurovic/Downloads/GCP Keys/gd-gcp-gridu-devops-t1-t2-34ba8a7c6a18.json")
  credentials = file("/Users/vdjurovic/Downloads/GCP Keys/compute_key_t1_t2.json")
  project     = "gd-gcp-gridu-devops-t1-t2"
  region      = "us-central1"
}

# Create a GKE cluster with zero initial nodes
resource "google_container_cluster" "ilekic_cluster" {
  name     = "ilekic-cluster"
  location = "us-central1"
  deletion_protection = false
  initial_node_count = 1
  #remove_default_node_pool = true
}

## Scale up the GKE cluster
#resource "google_container_node_pool" "ilekic_pool" {
#  name               = google_container_cluster.ilekic_cluster.node_pool[0].name
#  project            = google_container_cluster.ilekic_cluster.project
#  cluster            = google_container_cluster.ilekic_cluster.name
#  location           = google_container_cluster.ilekic_cluster.location
#  #initial_node_count = 3
#  node_config {
#    machine_type = "e2-medium"
#  }
#}

# Apply your Kubernetes resources
resource "null_resource" "apply_k8s_resources" {
  triggers = {
    config_sha = sha1(file("sock-shop.yaml"))
  }

  provisioner "local-exec" {
    command = "sleep 2m && kubectl apply -f sock-shop.yaml"
  }

  # Ensure the Kubernetes resource creation depends on the GKE cluster creation
  depends_on = [google_container_cluster.ilekic_cluster]
}
