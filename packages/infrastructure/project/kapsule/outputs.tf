output "host" {
  value = scaleway_k8s_cluster.app_cluster.kubeconfig[0].host
}

output "token" {
  value = scaleway_k8s_cluster.app_cluster.kubeconfig[0].token
}

output "ca_certificate" {
  value = base64decode(scaleway_k8s_cluster.app_cluster.kubeconfig[0].cluster_ca_certificate)
}
