variable "config" {
  description = "the context to run on"
}

variable "kube_config_path" {
  description = "the kube config location"
}

variable "namespace" {
  description = "namespace for deployment"
  default = "raeda"
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

variable "database_password" {
  description = "the keycloak database url"
  sensitive = true
}

variable "keycloak_database_port" {
  description = "the keycloak database port"
}

variable "database_username" {
  description = "the database username"
}


variable "keycloak_docker_image" {
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

variable "delivery_database_url" {
  description = "delivery database url"
}

variable "delivery_docker_image" {
  description = "delivery docker image version"
}

variable "keycloak_url" {
  description = "delivery keycloak url"
}

variable "graphql_docker_image" {
  description = "delivery docker image version"
}




