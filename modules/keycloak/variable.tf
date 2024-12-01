variable "namespace" {
  description = "application namespace"
}

variable "keycloak_admin_username" {
  description = "the keycloak username"
}

variable "keycloak_admin_password" {
  description = "the keycloak password"
  sensitive   = true
}

variable "keycloak_database_url" {
  description = "the keycloak database url"
}

variable "keycloak_database_password" {
  description = "the keycloak database url"
  sensitive = true
}


variable "keycloak_database_username" {
  description = "the keycloak database username"
}


variable "docker_image_name" {
  default = "zimesfield/keycloak:0.0.1"
}

variable "container_name" {
  default = "keycloak"
}

variable "keycloak_port" {
  default = 8080
}

variable "extra_debug_args" {
  default = "-p 5005:5005 -e JAVA_TOOL_OPTIONS=\"-agentlib:jdwp=transport=dt_socket,address=*:5005,server=y,suspend=n\""
}
