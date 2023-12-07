resource "kubernetes_horizontal_pod_autoscaler_v2" "backend_hpa" {
  metadata {
    name = "backend-hpa"
  }

  spec {
    max_replicas = 6
    min_replicas = 1

    scale_target_ref {
      api_version = "apps/v2"
      kind        = "Deployment"
      name        = kubernetes_deployment.backend.metadata.0.name
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
