data "kubernetes_secret" "loki" {
  metadata {
    name      = "loki-grafana"
    namespace = "loki"
  }
}
