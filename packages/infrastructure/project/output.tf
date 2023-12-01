output "kapsule" {
  description = "Kapsule cluster id"
  value       = scaleway_k8s_cluster.app_cluster.id
}
