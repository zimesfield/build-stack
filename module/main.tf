module "artifact_registry" {
  source = "./storage"
  bucket_access_key = var.bucket_access_key
  bucket_secret_key = var.bucket_secret_key
  bucket_label = var.bucket_label
}