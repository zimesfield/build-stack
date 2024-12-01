
resource "kubernetes_secret" "keycloak_db_credentials" {
  metadata {
    name      = "${var.container_name}-db-credentials"
    namespace = var.namespace
  }
  data = {
    username = base64encode(var.keycloak_database_username)
    password = base64encode(var.keycloak_database_password)
    db_url   = base64encode(var.keycloak_database_url)
  }
}


resource "kubernetes_deployment" "keycloak_service" {
  metadata {
    name      = var.container_name
    namespace = var.namespace
    labels = {
      app = "keycloak"
    }
  }


  spec {
    replicas = 1

    selector {
      match_labels = {
        app = var.container_name
      }
    }

    template {
      metadata {
        labels = {
          app = var.container_name
        }
      }

      spec {
        container {
          name  = var.container_name
          image = var.docker_image_name

          command = [
            "/opt/keycloak/bin/kc.sh",
            "start-dev"
          ]
          port {
            container_port = 8080
          }

          env {
            name  = "KC_LOG_LEVEL"
            value = "info,debug,com.zimesfield.keycloak:debug,org.keycloak:debug,org.keycloak.transaction.JtaTransactionWrapper:info"
          }

          env {
            name  = "KEYCLOAK_ADMIN"
            value = var.keycloak_admin_username
          }

          env {
            name  = "KEYCLOAK_ADMIN_PASSWORD"
            value = var.keycloak_admin_password
          }

          env {
            name  = "CORE_SERVER_RMI_HOSTS"
            value = "dev-stage-minion1.mercateo.lan dev-stage-minion2.mercateo.lan"
          }

          env {
            name  = "BUYER_VIEW_SERVER_RMI_HOSTS"
            value = "dev-stage-minion1.mercateo.lan dev-stage-minion2.mercateo.lan"
          }

          env {
            name  = "KC_SPI_STORAGE_MERCATEO_PUNCHOUT_SERVICE_REST_URL"
            value = "https://punchout-internal.devstage.unite.eu"
          }

          env {
            name  = "KC_SPI_LOGIN_CUSTOM_FREEMARKER_SSO_SYSTEM_URL"
            value = "https://dev-stage.raedaexpress.com/login"
          }

          env {
            name  = "KC_HOSTNAME_STRICT"
            value = "false"
          }

          env {
            name  = "KC_HOSTNAME_STRICT_HTTPS"
            value = "false"
          }

          env {
            name  = "KC_HTTP_ENABLED"
            value = "true"
          }

          env {
            name  = "KC_LOG_CONSOLE_COLOR"
            value = "true"
          }

          env {
            name  = "KEYCLOAK_ADMIN"
            value = var.keycloak_admin_username
          }

          env_from {
            secret_ref {
              name = kubernetes_secret.keycloak_db_credentials.metadata[0].name
            }
          }

          resources {
            requests = {
              memory = "512Mi"
              cpu    = "500m"
            }
            limits = {
              memory = "1Gi"
              cpu    = "1"
            }
          }

          readiness_probe {
            http_get {
              path = "/"
              port = 8080
            }
            initial_delay_seconds = 30
            period_seconds        = 10
          }

          liveness_probe {
            http_get {
              path = "/"
              port = 8080
            }
            initial_delay_seconds = 30
            period_seconds        = 10
          }
        }
      }
    }
  }
}


resource "kubernetes_service" "keycloak" {
  metadata {
    name = "${var.container_name}-service"
    namespace = var.namespace
    labels = {
      name = var.container_name
    }
  }

  spec {
    selector = {
      app = var.container_name
    }

    port {
      port        = 80
      target_port = 8080
    }

    type = "ClusterIP"
  }
}

output "keycloak_deployment_name" {
  value = "${kubernetes_deployment.keycloak_service.metadata[0].name}.keycloak.svc.cluster.local"
  description = "The name of the Keycloak deployment."
}
