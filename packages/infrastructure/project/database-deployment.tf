resource "kubernetes_service_account" "mongodb" {
  metadata {
    name = "mongodb-account"
  }
}

resource "kubernetes_cluster_role" "mongodb" {


  metadata {
    name = "mongodb-role"
  }

  rule {
    api_groups = [""]
    resources  = ["configmaps"]
    verbs      = ["*"]
  }

  rule {
    api_groups = [""]
    resources  = ["deployments"]
    verbs      = ["list", "watch"]
  }

  rule {
    api_groups = [""]
    resources  = ["services"]
    verbs      = ["*"]
  }

  rule {
    api_groups = [""]
    resources  = ["pods"]
    verbs      = ["get", "list", "watch"]
  }
}

resource "kubernetes_cluster_role_binding" "mongodb" {
  metadata {
    name = "mongodb-role-binding"
  }

  subject {
    kind = "ServiceAccount"
    name = kubernetes_service_account.mongodb.metadata.0.name
  }

  role_ref {
    api_group = "rbac.authorization.k8s.io"
    kind      = "ClusterRole"
    name      = kubernetes_cluster_role.mongodb.metadata.0.name
  }
}

resource "kubernetes_stateful_set" "mongodb" {
  metadata {
    name = "mongodb-replica"
  }

  spec {
    service_name = kubernetes_service.mongodb.metadata.0.name

    replicas = 3

    selector {
      match_labels = {
        app = "mongodb"
      }
    }

    template {
      metadata {
        labels = {
          app      = "mongodb"
          selector = "mongodb"
        }
      }

      spec {
        service_account_name             = kubernetes_service_account.mongodb.metadata.0.name
        termination_grace_period_seconds = 30

        container {
          image = "mongo:7.0.4"
          name  = "mongodb"

          command = ["/bin/sh"]
          args    = ["-c", "mongod --replSet=rs0 --bind_ip_all"]

          resources {
            limits = {
              cpu    = "0.5"
              memory = "512Mi"
            }

            requests = {
              cpu    = "0.5"
              memory = "512Mi"
            }
          }

          port {
            name           = "mongodb-port"
            container_port = 27017
          }

          volume_mount {
            mount_path = "/data/db"
            name       = "mongodb-data"
          }
        }
      }
    }

    volume_claim_template {
      metadata {
        name = "mongodb-data"
      }

      spec {
        access_modes = ["ReadWriteOnce"]
        resources {
          requests = {
            storage = "1Gi"
          }
        }
      }
    }
  }
}
