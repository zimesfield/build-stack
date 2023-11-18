module "istio" {
  source  = "boeboe/istio/helm"
  version = "0.0.2"

  istio_version = "1.15.3"

  istio_istiod_settings = {
    "pilot.autoscaleMin" = 1
    "pilot.autoscaleMax" = 4
  }

  istio_gateway_settings = {
    "autoscaling.minReplicas" = 1
    "autoscaling.maxReplicas" = 4
  }
}
