resource "kubernetes_config_map" "redis_cluster_configmap" {
  metadata {
    name = "redis-config"
  }

  data = {
    "redis.conf" = file("${path.module}/config/redis.conf")
  }
}
