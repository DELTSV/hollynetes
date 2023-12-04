resource "kubernetes_secret" "backend_env_secrets" {
  metadata {
    name = "backend-env-secrets"
  }

  data = {
    "HF_TMDB_API_KEY"              = var.tmdb_api_key
    "HF_GOOGLE_AUTH_CLIENT_ID"     = var.google_auth_client_id
    "HF_GOOGLE_AUTH_CLIENT_SECRET" = var.google_auth_client_secret
    "HF_ADMIN_PASSWORD"            = var.admin_password
    "HF_DB_PASSWORD"               = var.mongo_root_password
    "HF_JWT_SECRET"                = var.jwt_secret
  }

  type = "Opaque"
}
