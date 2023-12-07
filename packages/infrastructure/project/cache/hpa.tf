resource "kubernetes_horizontal_pod_autoscaler_v2" "redis_hpa" {
  metadata {
    name = "redis-hpa"
  }

  spec {
    max_replicas = 6
    min_replicas = 1

    scale_target_ref {
      api_version = "apps/v2"
      kind        = "StatefulSet"
      name        = kubernetes_stateful_set.redis_cluster.metadata.0.name
    }

    metric {
      type = "Resource"

      resource {
        name = "cpu"

        target {
          type = "Utilization"
          average_utilization = 70
        }
      }
    }
  }
}
