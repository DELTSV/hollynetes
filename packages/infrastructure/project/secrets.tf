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

resource "kubernetes_secret" "backend_tmdb_api_key" {
  metadata {
    name = "backend-tmdb-api-key"
  }

  data = var.backend_tmdb_api_key

  type = "Opaque"
}
