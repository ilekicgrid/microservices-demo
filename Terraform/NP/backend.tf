terraform {
  backend "gcs" {
    bucket = "viv_bucket"
    prefix = "terraform/state/NP"
  }
}