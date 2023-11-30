resource "kubernetes_ingress_v1" "app" {
  metadata {
    name = "app-ingress"
  }

  spec {
    rule {
      http {
        path {
          path = "/frontend"
          backend {
            service {
              name = kubernetes_service.frontend.metadata[0].name
              port {
                number = kubernetes_service.frontend.spec[0].port[0].port
              }
            }
          }
        }

        path {
          path = "/backend"
          backend {
            service {
              name = kubernetes_service.backend.metadata[0].name
              port {
                number = kubernetes_service.backend.spec[0].port[0].port
              }
            }
          }
        }
      }
    }
  }
}
