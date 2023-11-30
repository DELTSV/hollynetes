resource "kubernetes_service" "mongodb" {
  metadata {
    name = "mongodb-service"
  }

  spec {
    selector = {
      app = kubernetes_deployment.mongodb.spec[0].template[0].metadata[0].labels.app
    }

    port {
      port        = 27017
      target_port = 27017
    }
  }
}
