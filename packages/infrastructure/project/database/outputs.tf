output "dns_name" {
  value = "${kubernetes_service.mongodb_headless.metadata.0.name}.${kubernetes_service.mongodb_headless.metadata.0.namespace}"
}

output "mongodb_root_password_secret_name" {
  value = kubernetes_secret.mongodb_root_password.metadata.0.name
}
