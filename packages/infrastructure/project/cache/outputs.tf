output "redis_password_secret_name" {
  value = kubernetes_secret.redis_cluster_password.metadata.0.name
}
