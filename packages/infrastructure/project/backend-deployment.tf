resource "kubernetes_deployment" "backend" {
  metadata {
    name = "backend-deployment"
  }

  spec {
    replicas = 3

    selector {
      match_labels = {
        app = "backend"
      }
    }

    template {
      metadata {
        labels = {
          app = "backend"
        }
      }

      spec {
        container {
          image = "nginxdemos/hello:latest"
          name  = "backend-container"

          port {
            container_port = 8080
          }

          env {
            name  = "MONGO_URI"
            value = "mongodb://mongo-service:27017/your-database"
          }
        }
      }
    }
  }
}
