output "kapsule" {
  description = "Kapsule cluster id"
  value       = scaleway_k8s_cluster.main_cluster.id
}
