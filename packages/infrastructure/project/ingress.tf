resource "helm_release" "ingress" {
  name       = "ingress"
  repository = "https://kubernetes.github.io/ingress-nginx"
  chart      = "ingress-nginx"
  version    = "4.5.2"
}

resource "kubernetes_ingress_v1" "app_ingress" {
  metadata {
    name = "app-ingress"

    annotations = {
      "nginx.ingress.kubernetes.io/ssl-redirect"   = "false"
      "nginx.ingress.kubernetes.io/use-regex"      = "true"
      "nginx.ingress.kubernetes.io/rewrite-target" = "/$2"
    }
  }

  spec {
    ingress_class_name = "nginx"

    rule {
      http {
        path {
          path      = "/frontend(/|$)(.*)"
          path_type = "Prefix"

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
          path      = "/backend(/|$)(.*)"
          path_type = "Prefix"

          backend {
            service {
              name = kubernetes_service.backend.metadata[0].name
              port {
                number = kubernetes_service.backend.spec[0].port[0].port
              }
            }
          }
        }

        path {
          path      = "/(.*)"
          path_type = "Prefix"

          backend {
            service {
              name = kubernetes_service.frontend.metadata[0].name
              port {
                number = kubernetes_service.frontend.spec[0].port[0].port
              }
            }
          }
        }
      }
    }
  }
}

resource "kubernetes_ingress_v1" "app_ingress_static" {
  metadata {
    name = "app-ingress-static"

    annotations = {
      "nginx.ingress.kubernetes.io/ssl-redirect"   = "false"
      "nginx.ingress.kubernetes.io/rewrite-target" = "/static/$2"
    }
  }

  spec {
    ingress_class_name = "nginx"

    rule {
      http {
        path {
          path      = "/static(/|$)(.*)"
          path_type = "Prefix"

          backend {
            service {
              name = kubernetes_service.frontend.metadata[0].name
              port {
                number = kubernetes_service.frontend.spec[0].port[0].port
              }
            }
          }
        }
      }
    }
  }
}
