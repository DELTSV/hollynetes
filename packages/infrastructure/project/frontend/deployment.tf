resource "kubernetes_deployment" "frontend" {
  metadata {
    name = "frontend-deployment"
  }

  spec {
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

        volume {
          name = "nginx-config-volume"
          config_map {
            name = kubernetes_config_map.nginx_frontend_website_config.metadata[0].name
          }
        }

        container {
          image = var.image
          name  = "frontend-container"

          volume_mount {
            name       = "nginx-config-volume"
            mount_path = "/etc/nginx/conf.d"
          }

          port {
            container_port = 80
          }

          resources {
            limits = {
              cpu    = "500m"
              memory = "128Mi"
            }

            requests = {
              cpu    = "250m"
              memory = "48Mi"
            }
          }
        }
      }
    }
  }

  depends_on = [
    kubernetes_config_map.nginx_frontend_website_config
  ]
}
