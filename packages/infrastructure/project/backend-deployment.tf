resource "kubernetes_deployment" "backend" {
  metadata {
    name = "backend-deployment"
  }

  spec {
    replicas = 3

    selector {
      match_labels = {
        app = "backend"
      }
    }

    template {
      metadata {
        labels = {
          app = "backend"
        }
      }

      spec {
        container {
          image = var.backend_image
          name  = "backend-container"

          port {
            container_port = 3000
          }

          env {
            name  = "HF_APP_PORT"
            value = 3000
          }

          env {
            name  = "HF_APP_ENV"
            value = "prod"
          }

          env {
            name  = "HF_TMDB_API_KEY"
            value_from {
              secret_key_ref = kubernetes_secret.backend_tmdb_api_key.metadata.0.name
            }
          }

          env {
            name  = "HF_APP_URLS_WHITELIST"
            value = "https://hollynetes.fr"
          }

          env {
            name  = "HF_DB_NAME"
            value = "hollynetes"
          }

          env {
            name  = "HF_MAILS_USER"
            value = "noreply@hollynetes.fr"
          }

          env {
            name  = "HF_MAILS_HOST"
            value = "mail.hollynetes.fr"
          }

          env {
            name  = "HF_APP_VERBOSE"
            value = 0
          }

          env {
            name  = "HF_SSL_ENABLED"
            value = 0
          }
        }
      }
    }
  }
}
