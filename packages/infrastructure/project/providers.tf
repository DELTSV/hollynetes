provider "scaleway" {
  access_key = var.access_key_id
  secret_key = var.secret_key
  project_id = var.project_id
}

provider "helm" {
  debug = true
  kubernetes {
    host                   = scaleway_k8s_cluster.app_cluster.kubeconfig[0].host
    token                  = scaleway_k8s_cluster.app_cluster.kubeconfig[0].token
    cluster_ca_certificate = base64decode(scaleway_k8s_cluster.app_cluster.kubeconfig[0].cluster_ca_certificate)
  }
}

provider "kubernetes" {
  host                   = scaleway_k8s_cluster.app_cluster.kubeconfig[0].host
  token                  = scaleway_k8s_cluster.app_cluster.kubeconfig[0].token
  cluster_ca_certificate = base64decode(scaleway_k8s_cluster.app_cluster.kubeconfig[0].cluster_ca_certificate)
}

