resource "helm_release" "ingress" {
  name       = "ingress"
  repository = "https://kubernetes.github.io/ingress-nginx"
  chart      = "ingress-nginx"
  version    = "4.8.3"
}

resource "kubernetes_ingress_v1" "app_ingress" {
  metadata {
    name = "app-ingress"

    annotations = {
      "nginx.ingress.kubernetes.io/ssl-redirect"    = "true"
      "nginx.ingress.kubernetes.io/ssl-passthrough" = "false"
      "nginx.ingress.kubernetes.io/use-regex"       = "true"
    }
  }

  spec {
    ingress_class_name = "nginx"

    tls {
      hosts       = [var.domain_name]
      secret_name = kubernetes_secret.tls_cert.metadata[0].name
    }

    rule {
      host = var.domain_name

      http {
        path {
          path      = "/api(/|$)(.*)"
          path_type = "Prefix"

          backend {
            service {
              name = var.backend_service_name
              port {
                number = var.backend_service_port
              }
            }
          }
        }

        path {
          path      = "/"
          path_type = "Prefix"

          backend {
            service {
              name = var.frontend_service_name
              port {
                number = var.frontend_service_port
              }
            }
          }
        }
      }
    }
  }
}

