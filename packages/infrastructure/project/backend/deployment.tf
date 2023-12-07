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
          image = var.image
          name  = "backend-container"

          port {
            container_port = 3000
          }

          env_from {
            secret_ref {
              name = kubernetes_secret.backend_env_secrets.metadata.0.name
            }
          }

          env {
            name = "HF_DB_PASSWORD"

            value_from {
              secret_key_ref {
                name = var.mongo_root_password_secret_name
                key  = "mongo-root-password"
              }
            }
          }

          env {
            name = "HF_REDIS_PASSWORD"

            value_from {
              secret_key_ref {
                name = var.redis_password_secret_name
                key  = "redis-password"
              }
            }
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
            name  = "HF_APP_URLS_WHITELIST"
            value = "https://hollynetes.fr"
          }

          env {
            name  = "HF_DB_NAME"
            value = "hollynetes"
          }

          env {
            name  = "HF_DB_HOST"
            value = var.database_dns_name
          }

          env {
            name  = "HF_DB_PORT"
            value = 27017
          }

          env {
            name  = "HF_DB_USER"
            value = "root"
          }

          env {
            name  = "HF_MAILS_HOST"
            value = "mail.hollynetes.fr"
          }
        }
      }
    }
  }
}
