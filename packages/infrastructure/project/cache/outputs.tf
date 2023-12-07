output "dns_name" {
  value = "${kubernetes_service.redis_headless.metadata.0.name}.${kubernetes_service.redis_headless.metadata.0.namespace}"
}

output "redis_password_secret_name" {
  value = kubernetes_secret.redis_cluster_password.metadata.0.name
}
