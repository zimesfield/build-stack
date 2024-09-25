module "backend" {
  source               = "git::git@github.com:zimesfield/infrastructure-stack.git//modules/storage?ref=v.0.1.8"
  object_storage_key   = "terraform_state"
  region               = "eu-central-1"
  token                = var.token
  file_path            = var.terraform_env_state_file
  storage_bucket_label = "terraform.tfstate"
  storage_key_label    = "terraform.tfstate"
}


