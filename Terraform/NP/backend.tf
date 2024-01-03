terraform {
  backend "gcs" {
    bucket = "viv_bucket_np"
    prefix = "terraform/state"
  }
}