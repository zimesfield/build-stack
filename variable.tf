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



#
#
#
# variable "keycloak_db_user" {
#   description = "the keycloak database username"
#   default     = "raeda-keycloak"
# }
#
# variable "keycloak_db_password" {
#   description = "the keycloak database password"
#   sensitive   = true
# }
#
# variable "keycloak_db_name" {
#   description = "the keycloak database name"
#   default     = "keycloak"
# }
#

#
# variable "k8s_config_file" {
#   description = "kube config location"
# }