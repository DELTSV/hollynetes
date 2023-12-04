resource "scaleway_vpc_private_network" "app_network" {
  name = "app-network"
  tags = ["terraform", "app"]

  ipv4_subnet {
    subnet = "172.16.12.0/22"
  }
}
