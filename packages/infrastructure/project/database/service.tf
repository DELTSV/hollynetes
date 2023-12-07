resource "kubernetes_service" "mongodb_headless" {
  metadata {
    name = "mongodb"
  }

  spec {
    selector = {
      app = "mongodb"
    }

    port {
      name = "mongodb"
      port = 27017
    }

    cluster_ip = "None"
  }
}
