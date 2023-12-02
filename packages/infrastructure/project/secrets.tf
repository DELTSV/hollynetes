resource "kubernetes_secret" "tls_cert" {
  metadata {
    name = "tls-cert"
  }

  data = {
    "tls.crt" = file("${path.module}/certs/server.crt")
    "tls.key" = file("${path.module}/certs/server.key")
  }

  type = "kubernetes.io/tls"
}

resource "kubernetes_secret" "backend_env_secrets" {
  metadata {
    name = "backend-env-secrets"
  }

  data = {
    "HF_TMDB_API_KEY"              = var.backend_tmdb_api_key
    "HF_GOOGLE_AUTH_CLIENT_ID"     = var.backend_google_auth_client_id
    "HF_GOOGLE_AUTH_CLIENT_SECRET" = var.backend_google_auth_client_secret
    "HF_ADMIN_PASSWORD"            = var.backend_admin_password
  }

  type = "Opaque"
}
