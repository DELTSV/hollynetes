output "dns_name" {
  value = "${kubernetes_service.mongodb-headless.metadata.0.name}.${kubernetes_service.mongodb-headless.metadata.0.namespace}"
}
