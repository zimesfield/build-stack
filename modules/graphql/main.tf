resource "kubernetes_deployment" "graphql_app" {
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
          command = [
#             "/bin/sh",
#             "-c",
            "pnpm",
            "start"
          ]
        }
      }
    }
  }
}

resource "kubernetes_service" "graphql_service" {
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


output "graphql_deployment_name" {
  value = kubernetes_deployment.graphql_app.metadata[0].name
  description = "The name of the graphql deployment."
}