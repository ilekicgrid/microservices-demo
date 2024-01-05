terraform {
  backend "gcs" {
    bucket = "ilija_bucket_np"
    prefix = "terraform/state"
  }
}