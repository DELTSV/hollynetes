resource "kubernetes_service" "mongodb" {
  metadata {
    name = "mongodb-service"
  }

  spec {
    selector = {
      app = "mongodb"
    }

    port {
      port        = 27017
      target_port = 27017
    }

    cluster_ip = "None"
  }
}
