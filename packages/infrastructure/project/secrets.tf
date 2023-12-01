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
