terraform {
  backend "gcs" {
    bucket = "ilija_bucket_pr"
    prefix = "terraform/state"
  }
}