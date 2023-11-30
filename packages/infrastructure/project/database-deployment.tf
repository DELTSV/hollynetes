resource "kubernetes_deployment" "mongodb" {
  metadata {
    name = "mongodb-deployment"
  }

  spec {
    replicas = 1

    selector {
      match_labels = {
        app = "mongodb"
      }
    }

    template {
      metadata {
        labels = {
          app = "mongodb"
        }
      }

      spec {
        container {
          image = "mongo:latest"
          name  = "mongodb-container"

          port {
            container_port = 27017
          }
        }
      }
    }
  }
}
