terraform {
  required_version = ">= 1"
  required_providers {
    linode = {
      source = "linode/linode"
      version = "2.28.0"
    }
  }
}

resource "linode_object_storage_bucket" "artifact-registry" {
  region = var.region
  label = var.bucket_label
  access_key = var.bucket_access_key
  secret_key = var.bucket_secret_key

#  lifecycle_rule {
#    id      = "life_cycle_of_incomplete_upload"
#    enabled = true
#
#    abort_incomplete_multipart_upload_days = 2
#  }
}


