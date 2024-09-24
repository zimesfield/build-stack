terraform {
  backend "local" {
    // don't store state in terraform workdirs otherwise terraform tries to migrate it when switching to remote backend
    path = ".local/terraform.tfstate"
  }
}
