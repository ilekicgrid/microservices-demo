# Authenticate with GCP
provider "google" {
  project     = "gd-gcp-gridu-devops-t1-t2"
  region      = "us-central1"
}

# Create a GKE cluster with zero initial nodes
resource "google_container_cluster" "ilekic_cluster_np" {
  name     = "ilekic-cluster-np"
  location = "us-central1"
  deletion_protection = false
  initial_node_count = 1
  #remove_default_node_pool = true
#  enable_autopilot = true
}
# Create a node pool with horizontal autoscaling
resource "google_container_node_pool" "ilekic_autoscaling_node_pool" {
  name       = "ilekic-autoscaling-node-pool"
  location   = "us-central1"
  cluster    = google_container_cluster.ilekic_cluster_np.name
  node_count = 1

   autoscaling {
     min_node_count = 1
     max_node_count = 5
   }

  node_config {
    # preemptible  = false
    machine_type = "e2-medium"
    disk_size_gb = 150
  }
}

