
module "keycloak_service" {
  source                     = "./modules/keycloak"
  keycloak_admin_password    = var.keycloak_admin_password
  keycloak_admin_username    = var.keycloak_admin_username
  keycloak_database_password = var.database_password
  keycloak_database_url      = var.keycloak_database_url
  keycloak_database_username = var.database_username
  namespace                  = kubernetes_namespace.apps.metadata[0].name
}

module "delivery_service" {
  source                     = "./modules/delivery"
  depends_on                 = [module.keycloak_service]
  delivery_database_url      = var.delivery_database_url
  delivery_database_username = var.database_username
  delivery_database_password = var.database_password
  keycloak_url               = var.keycloak_url
  docker_image_name          = var.delivery_docker_image
  namespace                  = kubernetes_namespace.apps.metadata[0].name
}

module "graphql_service" {
  source                     = "./modules/graphql"
  depends_on                 = [module.delivery_service]
  docker_image_name          = var.graphql_docker_image
  namespace                  = kubernetes_namespace.apps.metadata[0].name
}

# # Display load balancer hostname (typically present in AWS)
# output "load_balancer_hostname" {
#   value = kubernetes_ingress_v1.raeda_ingress.status.0.load_balancer.0.ingress.0.hostname
# }
#
# # Display load balancer IP (typically present in GCP, or using Nginx ingress controller)
# output "load_balancer_ip" {
#   value = kubernetes_ingress.example.status.0.load_balancer.0.ingress.0.ip
# }

