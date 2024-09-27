variable "token" {
  description = "The name of the Kubernetes namespace"
  type        = string
}

variable "region" {
  description = "Server region"
  type        = string
}

variable "config" {
  description = "the context to run on"
}


variable "kube_config_path" {
  description = "the kube config location"
}

variable "keycloak_admin_username" {
  description = "the keycloak username"
}

variable "keycloak_admin_password" {
  description = "the keycloak password"
  sensitive   = true
}

variable "keycloak_port" {
  description = "the keycloak port"
}


variable "keycloak_database" {
  description = "the keycloak database name"
}


variable "keycloak_database_username" {
  description = "the keycloak database username"
}


variable "keycloak_database_password" {
  description = "the keycloak database password"
}


variable "bucket_access_key" {
  description = "storage access key"
}
variable "bucket_secret_key" {
  description = "storage secret key"
}

variable "bucket_label" {
  description = "The bucket id for storage. (required)"
}