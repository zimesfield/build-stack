output "istio_istiod_helm_metadata" {
  description = "block status of the istio istiod helm release"
  value = module.istio.istio_istiod_helm_metadata[0]
}