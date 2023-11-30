resource "kubernetes_deployment" "frontend" {
  metadata {
    name = "frontend-deployment"
  }

  spec {
    replicas = 3

    selector {
      match_labels = {
        app = "frontend"
      }
    }

    template {
      metadata {
        labels = {
          app = "frontend"
        }
      }

      spec {
        container {
          image = "nginxdemos/hello:latest"
          name  = "frontend-container"

          port {
            container_port = 80
          }
        }
      }
    }
  }
}
