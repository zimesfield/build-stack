

resource "kubernetes_secret" "delivery_db_credentials" {
  metadata {
    name      = "${var.container_name}-db-credentials"
    namespace = var.namespace
  }
  data = {
    username = base64encode(var.delivery_database_username)
    password = base64encode(var.delivery_database_password)
    db_url   = base64encode(var.delivery_database_url)
  }
}

# Create ConfigMap for environment variables
resource "kubernetes_config_map" "delivery_env_vars" {
  metadata {
    name = "${var.container_name}-environment-variables"
    namespace = var.namespace
  }

  data = {
    _JAVA_OPTIONS = "-Xmx512m -Xms256m"
    SPRING_PROFILES_ACTIVE = "prod,api-docs"
    MANAGEMENT_PROMETHEUS_METRICS_EXPORT_ENABLED = "true"
    SPRING_DATASOURCE_URL = var.delivery_database_url
    SPRING_LIQUIBASE_URL = var.delivery_database_url
    SPRING_LIQUIBASE_USER = var.delivery_database_username
    SPRING_LIQUIBASE_PASSWORD = var.delivery_database_password
    SPRING_SECURITY_OAUTH2_CLIENT_PROVIDER_OIDC_ISSUER_URI = var.keycloak_url
    SPRING_SECURITY_OAUTH2_CLIENT_REGISTRATION_OIDC_CLIENT_ID = "raeda"
    SPRING_SECURITY_OAUTH2_CLIENT_REGISTRATION_OIDC_CLIENT_SECRET = "web_app"
#     SPRING_ELASTICSEARCH_URIS = "http://elasticsearch:9200"
#     SPRING_CLOUD_STREAM_KAFKA_BINDER_BROKERS = "kafka:9092"
  }
}

resource "kubernetes_deployment" "delivery_app" {
  metadata {
    name = var.container_name
    namespace = var.namespace
    labels = {
      app = var.container_name
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
          image_pull_policy = "Always"

          env_from {
            config_map_ref {
              name = kubernetes_config_map.delivery_env_vars.metadata[0].name
            }
          }
        }
      }
    }
  }
}

resource "kubernetes_service" "delivery_service" {
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
      port        = "80"
      target_port = var.application_port
    }

    type = "ClusterIP"
  }
}


output "delivery_deployment_name" {
  value = kubernetes_deployment.delivery_app.metadata[0].name
  description = "The name of the delivery deployment."
}