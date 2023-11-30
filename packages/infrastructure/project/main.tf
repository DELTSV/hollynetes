terraform {
  required_providers {
    scaleway = {
      source = "scaleway/scaleway"
    }
    kubernetes = {
      source = "hashicorp/kubernetes"
    }
  }

  backend "s3" {
    bucket = "tfstate"
    key    = "state.tfstate"
    region = "fr-par"
    endpoints = {
      s3 = "https://s3.fr-par.scw.cloud"
    }
    skip_credentials_validation = true
    skip_region_validation      = true
    skip_requesting_account_id  = true
  }
}

provider "scaleway" {
  access_key = var.access_key_id
  secret_key = var.secret_key
  project_id = var.project_id
}

provider "kubernetes" {
  host                   = scaleway_k8s_cluster.main_cluster.kubeconfig[0].host
  token                  = scaleway_k8s_cluster.main_cluster.kubeconfig[0].token
  cluster_ca_certificate = base64decode(scaleway_k8s_cluster.main_cluster.kubeconfig[0].cluster_ca_certificate)
}

