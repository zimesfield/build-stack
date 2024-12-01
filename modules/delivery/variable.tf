
variable "namespace" {
  description = "application namespace"
}

variable "keycloak_url" {
  description = "the keycloak database url"
}

variable "delivery_database_url" {
  description = "delivery database url"
}

variable "delivery_database_password" {
  description = "delivery database url"
  sensitive = true
}

variable "delivery_database_username" {
  description = "the keycloak database username"
}


variable "docker_image_name" {
  default = "zimesfield/delivery:0.0.4"
}

variable "container_name" {
  default = "delivery"
}

variable "application_port" {
  default = 8082
}

