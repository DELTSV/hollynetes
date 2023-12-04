output "service_name" {
  value = kubernetes_service.backend.metadata.0.name
}

output "service_port" {
  value = kubernetes_service.backend.spec[0].port[0].target_port
}
