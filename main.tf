module "keycloak-database" {
  source         = "git::git@github.com:zimesfield/infrastructure-stack.git//modules/postgres?ref=v0.2.0"
  namespace_name = "keycloak"
  chart_name     = "postgresql"
  app_name       = "keycloak-database"
  app_version    = "13.1.2"
  db_name        = var.keycloak_database
  db_username    = var.keycloak_database_username
  db_password    = var.keycloak_database_password
}

module "keycloak-server" {
  source             = "git::git@github.com:zimesfield/infrastructure-stack.git//modules/keycloak?ref=v0.2.0"
  depends_on         = [module.keycloak-database]
  namespace          = "keycloak"
  chart              = "keycloak"
  app_version        = "16.1.5"
  app_name           = "keycloak-server"
  username           = var.keycloak_admin_username
  password           = var.keycloak_admin_password
  db_host            = "keycloak-database-postgresql"
  db_port            = var.keycloak_port
  db_name            = var.keycloak_database
  db_username        = var.keycloak_database_username
  db_password_secret = "keycloak-database-postgresql"
  db_password_key    = "password"
}


# resource "kubernetes_namespace" "istio_system" {
#   metadata {
#     name = "istio-system"
#   }
# }
#
# # Istio Gateway
# resource "kubernetes_manifest" "istio_gateway" {
#   manifest = {
#     apiVersion = "networking.istio.io/v1alpha3"
#     kind       = "Gateway"
#     metadata = {
#       name      = "keycloak-gateway"
#       namespace = "default"
#     }
#     spec = {
#       selector = {
#         istio = "ingressgateway"
#       }
#       servers = [{
#         port = {
#           number   = 80
#           name     = "http"
#           protocol = "HTTP"
#         }
#         hosts = ["*"]
#       }]
#     }
#   }
# }
#
# # Istio Virtual Service
# resource "kubernetes_manifest" "istio_virtual_service" {
#   manifest = {
#     apiVersion = "networking.istio.io/v1alpha3"
#     kind       = "VirtualService"
#     metadata = {
#       name      = "keycloak-vs"
#       namespace = "default"
#     }
#     spec = {
#       hosts = ["*"]
#       gateways = ["keycloak-gateway"]
#       http = [{
#         match = [{
#           uri = {
#             prefix = "/"
#           }
#         }]
#         route = [{
#           destination = {
#             host = "keycloak.default.svc.cluster.local"
#             port = {
#               number = 8080
#             }
#           }
#         }]
#       }]
#     }
#   }
# }
