resource "kubernetes_deployment" "frontend" {
  metadata {
    name = "frontend-deployment"
  }

  spec {
    replicas = 3

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
          image = var.frontend_image
          name  = "frontend-container"

          volume_mount {
            name       = "nginx-config-volume"
            mount_path = "/etc/nginx/conf.d"
          }

          port {
            container_port = 80
          }
        }
      }
    }
  }
}

resource "kubernetes_config_map" "nginx_frontend_website_config" {
  metadata {
    name = "nginx-frontend-website-config"
  }

  data = {
    "default.conf" = file("${path.module}/config/nginx-frontend-website.conf")
  }
}
