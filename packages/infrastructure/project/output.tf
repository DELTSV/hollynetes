output "pool_node_public_ip" {
  description = "The public IP address of the pool node"
  value       = scaleway_k8s_pool.app_pool.nodes.0.public_ip
}

output "mongo_service_dns_name" {
  description = "The DNS name of the mongo service"
  value       = "${kubernetes_service.mongodb-headless.metadata.0.name}.${kubernetes_service.mongodb-headless.metadata.0.namespace}.svc.cluster.local"
}
