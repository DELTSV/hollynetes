resource "kubectl_manifest" "clusterissuer_letsencrypt" {
  depends_on = [helm_release.cert_manager]
  yaml_body = yamlencode({
    apiVersion = "cert-manager.io/v1"
    kind = "ClusterIssuer"
    metadata = {
      name = var.issuer_name
    }
    spec = {
      acme = {
        email = "lvandenbossche.jouvet@email.com"
        privateKeySecretRef = {
          name = var.private_key_secret_name
        }
        server = "https://acme-v02.api.letsencrypt.org/directory"
        solvers = [
          {
            http01 = {
              ingress = {
                class = "nginx"
              }
            }
          },
        ]
      }
    }
  })
}
