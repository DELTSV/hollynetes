provider "scaleway" {
  access_key = var.access_key_id
  secret_key = var.secret_key
  project_id = var.project_id
}

provider "helm" {
  debug = true
  kubernetes {
    host                   = module.kapsule.host
    token                  = module.kapsule.token
    cluster_ca_certificate = module.kapsule.ca_certificate
  }
}

provider "kubernetes" {
  host                   = module.kapsule.host
  token                  = module.kapsule.token
  cluster_ca_certificate = module.kapsule.ca_certificate
}

