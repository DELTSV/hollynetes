resource "scaleway_k8s_pool" "app_pool" {
  cluster_id = scaleway_k8s_cluster.app_cluster.id
  name       = "app-pool"
  node_type  = "DEV1-M"
  size       = 1
}
