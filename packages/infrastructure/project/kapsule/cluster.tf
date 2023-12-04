resource "scaleway_k8s_cluster" "app_cluster" {
  name                        = "app-cluster"
  version                     = "1.28.2"
  cni                         = "cilium"
  delete_additional_resources = false
  type                        = "kapsule"

  private_network_id = scaleway_vpc_private_network.app_network.id
  depends_on         = [scaleway_vpc_private_network.app_network]
}

