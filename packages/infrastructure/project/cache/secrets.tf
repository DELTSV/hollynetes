resource "kubernetes_secret" "redis_cluster_password" {
  metadata {
    name = "redis-cluster-password"
  }

  data = {
    "redis-password" = var.password
  }

  type = "Opaque"
}
