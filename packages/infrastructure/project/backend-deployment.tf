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

          env_from {
            secret_ref {
              name = kubernetes_secret.backend_env_secrets.metadata.0.name
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
            value = "mongodb.default.svc.cluster.local"
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
