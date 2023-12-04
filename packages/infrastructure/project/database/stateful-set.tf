resource "kubernetes_stateful_set" "mongodb" {
  metadata {
    name = "mongodb"
  }

  spec {
    service_name = "mongodb"

    selector {
      match_labels = {
        app = "mongodb"
      }
    }

    template {
      metadata {
        labels = {
          app = "mongodb"
        }
      }

      spec {
        container {
          image = "mongo:7.0.4"
          name  = "mongodb"

          port {
            container_port = 27017
            name           = "mongodb"
          }

          volume_mount {
            mount_path = "/data/db"
            name       = "mongodb"
          }

          env_from {
            secret_ref {
              name = kubernetes_secret.mongodb_env_secrets.metadata[0].name
            }
          }

          env {
            name  = "MONGO_INITDB_DATABASE"
            value = "hollynetes"
          }

          env {
            name  = "MONGO_INITDB_ROOT_USERNAME"
            value = "root"
          }
        }

        volume {
          name = "mongodb"

          persistent_volume_claim {
            claim_name = kubernetes_persistent_volume_claim.mongodb.metadata[0].name
          }
        }
      }
    }
  }
}
