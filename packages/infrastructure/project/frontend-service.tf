resource "kubernetes_service" "frontend" {
  metadata {
    name = "frontend-service"
  }

  spec {
    selector = {
      app = kubernetes_deployment.frontend.spec[0].template[0].metadata[0].labels.app
    }

    port {
      port        = 80
      target_port = 80
    }
  }
}
