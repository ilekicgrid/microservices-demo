terraform {
  backend "gcs" {
    bucket = "viv_bucket_pr"
    prefix = "terraform/state"
  }
}