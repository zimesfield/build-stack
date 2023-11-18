variable "namespace_name" {
  description = "The name of the Kubernetes namespace"
  type        = string
}
variable "app_name" {
  description = "The name of the app service"
  type        = string
}
variable "app_version" {
  description = "The version of image"
  type        = string
}
variable "chart_name" {
  description = "The name of the Kubernetes chart"
  type        = string
}
variable "db_password" {
  description = "The password of the database"
  type        = string
}
variable "db_username" {
  description = "The name of the db"
  type        = string
}
variable "db_name" {
  description = "The name of the db"
  type        = string
}


