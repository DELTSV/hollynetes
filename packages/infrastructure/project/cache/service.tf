resource "kubernetes_service" "redis_headless" {
  metadata {
    name = "redis-cluster"
  }

  spec {
    selector = {
      app = "redis-cluster"
    }

    port {
      name = "redis-client"
      port = 6379
    }

    cluster_ip = "None"
  }
}
