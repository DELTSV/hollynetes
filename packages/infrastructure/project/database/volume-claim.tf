resource "kubernetes_persistent_volume_claim" "mongodb" {
  metadata {
    name = "mongodb"
  }
  spec {
    access_modes = ["ReadWriteOnce"]
    resources {
      requests = {
        storage = "1Gi"
      }
    }
  }

  wait_until_bound = false
}
