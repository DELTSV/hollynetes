output "grafana_credentials" {
  value     = data.kubernetes_secret.loki.data["admin-password"]
  sensitive = true
}
