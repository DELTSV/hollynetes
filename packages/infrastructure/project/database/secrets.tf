resource "kubernetes_secret" "mongodb_root_password" {
  metadata {
    name = "mongodb-env-secrets"
  }

  data = {
    mongo-root-password = var.mongo_root_password
  }

  type = "Opaque"
}
