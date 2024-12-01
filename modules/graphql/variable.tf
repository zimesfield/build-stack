
variable "namespace" {
  description = "application namespace"
}

variable "docker_image_name" {
  default = "zimesfield/raeda-graphql:f545c92 "
}

variable "container_name" {
  default = "graphql"
}

variable "application_port" {
  default = 4000
}

