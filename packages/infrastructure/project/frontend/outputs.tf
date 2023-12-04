output "service_name" {
  value = kubernetes_service.frontend.metadata.0.name
}

output "service_port" {
  value = kubernetes_service.frontend.spec.0.port.0.port
}
