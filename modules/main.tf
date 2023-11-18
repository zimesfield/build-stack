variable "account_name" {
  type        = string
}

locals {
  istio_version = "1.14.4"
  istio_istiod_settings = {
    "pilot.autoscaleMin" = 1
    "pilot.autoscaleMax" = 4
    "global.tag"         = "1.14.4-tetratefips-v0-distroless"
  }
  istio_gateway_settings = {
    "autoscaling.minReplicas" = 1
    "autoscaling.maxReplicas" = 4
    "global.tag"              = "1.14.4-tetratefips-v0-distroless"
  }
}

module "keycloak_client" {
  source = "./keycloak"
  account_name = var.account_name
}

#module "kafka_client" {
#  source = "./kafka"
#}

#module "tid" {
#  source = "./istio"
#
#  istio_version          = local.istio_version
##  istio_istiod_settings  = local.istio_istiod_settings
##  istio_gateway_settings = local.istio_gateway_settings
#}

#output "istio_istiod_helm_metadata" {
#  description = "block status of the istio istiod helm release"
#  value       = module.tid.istio_istiod_helm_metadata[0]
#}
#
#data "kubernetes_service" "gateway" {
#  metadata {
#    name      = "istio-gateway"
#    namespace = "istio-system"
#  }
#
#  depends_on = [
#    module.tid
#  ]
#}
#
#output "gateway_loadbalancer_ip" {
#  description = "external loadbalancer ip address of ingress gateway"
#  value       = data.kubernetes_service.gateway.status[0].load_balancer[0]//.ingress[0].ip
#}




#module "tid" {
#  source  = "boeboe/tid/helm"
#  version = "0.0.1"
#
#  istio_version = "1.14.4"
#
#  istio_istiod_settings = {
#    "pilot.autoscaleMin" = 1
#    "pilot.autoscaleMax" = 4
#  }
#
#  istio_gateway_settings = {
#    "autoscaling.minReplicas" = 1
#    "autoscaling.maxReplicas" = 4
#  }
#}
#
#output "istio_istiod_helm_metadata" {
#  description = "block status of the istio istiod helm release"
#  value = module.tid.istio_istiod_helm_metadata[0]
#}
#
#output "gateway_loadbalancer_ip" {
#  description = "external loadbalancer ip address of ingress gateway"
#  value       = data.kubernetes_service.gateway.status[0].load_balancer[0].ingress[0].ip
#}


