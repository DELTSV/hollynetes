resource "kubernetes_secret" "mongodb_env_secrets" {
  metadata {
    name = "mongodb-env-secrets"
  }

  data = {
    "MONGO_INITDB_ROOT_PASSWORD" = var.mongo_root_password
  }

  type = "Opaque"
}
