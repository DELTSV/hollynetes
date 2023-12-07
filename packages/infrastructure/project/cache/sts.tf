resource "kubernetes_stateful_set" "redis_cluster" {
  metadata {
    name = "redis-cluster"
  }

  spec {
    service_name = "redis-cluster"
    replicas    = 3

    selector {
      match_labels = {
        app = "redis-cluster"
      }
    }

    template {
      metadata {
        labels = {
          app = "redis-cluster"
        }
      }

      spec {

        volume {
          name = "redis-config"
          empty_dir {}
        }

        volume {
          name = "config"
          config_map {
            name = "redis-config"
            default_mode = "0755"
          }
        }

        init_container {
          name = "config"
          image   = "redis:alpine"
          command    = [ "sh", "-c" ]
          args = [
            file("${path.module}/config/update-node.sh")
          ]

          env {
            name = "REDIS_PASSWORD"

            value_from {
              secret_key_ref {
                name = kubernetes_secret.redis_cluster_password.metadata.0.name
                key  = "redis-password"
              }
            }
          }

          volume_mount {
            mount_path = "/etc/redis/"
            name       = "redis-config"
          }

          volume_mount {
            mount_path = "/tmp/redis/"
            name       = "config"
          }
        }

        container {
          name    = "redis"
          image   = "redis:alpine"
          command = ["redis-server"]
          args = ["/etc/redis/redis.conf"]

          port {
            container_port = 6379
            name           = "client"
          }

          volume_mount {
            name      = "redis-config"
            mount_path = "/etc/redis/"
          }

          volume_mount {
            name      = "redis-cache-data"
            mount_path = "/data"
          }
        }
      }
    }

    volume_claim_template {
      metadata {
        name = "redis-cache-data"
      }

      spec {
        access_modes = ["ReadWriteOnce"]

        resources {
          requests = {
            storage = "500Mi"
          }
        }
      }
    }
  }
}
