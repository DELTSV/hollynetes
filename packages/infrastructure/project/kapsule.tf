resource "scaleway_k8s_cluster" "app_cluster" {
  name                        = "app-cluster"
  version                     = "1.28.2"
  cni                         = "cilium"
  delete_additional_resources = false
  type                        = "kapsule"

  private_network_id = scaleway_vpc_private_network.app_network.id
  depends_on         = [scaleway_vpc_private_network.app_network]
}

resource "scaleway_k8s_pool" "app_pool" {
  cluster_id = scaleway_k8s_cluster.app_cluster.id
  name       = "app-pool"
  node_type  = "DEV1-M"
  size       = 1
}

resource "scaleway_vpc_private_network" "app_network" {
  name = "app-network"
  tags = ["terraform", "app"]

  ipv4_subnet {
    subnet = "172.16.12.0/22"
  }
}
