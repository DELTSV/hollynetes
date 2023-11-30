resource "scaleway_k8s_cluster" "main_cluster" {
  name                        = "main-cluster"
  version                     = "1.28.2"
  cni                         = "cilium"
  delete_additional_resources = false
  type                        = "kapsule"

  private_network_id = scaleway_vpc_private_network.main_network.id
  depends_on         = [scaleway_vpc_private_network.main_network]
}

resource "scaleway_k8s_pool" "api_pool" {
  cluster_id = scaleway_k8s_cluster.main_cluster.id
  name       = "api-pool"
  node_type  = "DEV1-M"
  size       = 1
}

resource "scaleway_vpc_private_network" "main_network" {
  name = "main-network"
  tags = ["api", "database", "terraform"]

  ipv4_subnet {
    subnet = "172.16.12.0/22"
  }
}
