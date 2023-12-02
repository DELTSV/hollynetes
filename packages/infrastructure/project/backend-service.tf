resource "kubernetes_service" "backend" {
  metadata {
    name = "backend-service"
  }

  spec {
    selector = {
      app = kubernetes_deployment.backend.spec[0].template[0].metadata[0].labels.app
    }

    port {
      port        = 3000
      target_port = 3000
    }
  }
}
