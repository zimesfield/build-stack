resource "kubernetes_ingress_v1" "raeda_ingress" {
  metadata {
    name      = "${var.container_name}-ingress"
    namespace = var.namespace
    annotations = {
      "nginx.ingress.kubernetes.io/ssl-redirect"   = "true"
      "kubernetes.io/ingress.class"                     = "nginx"
      "nginx.ingress.kubernetes.io/rewrite-target"      = "/"
      "nginx.ingress.kubernetes.io/ssl-redirect"       = "false"
      "nginx.ingress.kubernetes.io/proxy-body-size"    = "10m"
    }
  }

  spec {
    rule {
      host = "keycloak.raedaexpress.com"
      http {
        path {
          path     = "/"
          path_type = "Prefix"
          backend {
            service {
              name = kubernetes_service.keycloak.metadata[0].name
              port {
                number = 80
              }
            }
          }
        }
      }
    }
  }
}
