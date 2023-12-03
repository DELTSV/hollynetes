data "scaleway_domain_zone" "hollynetes" {
  domain = var.domain_name
}

resource "scaleway_domain_record" "hollynetes" {
  dns_zone = data.scaleway_domain_zone.hollynetes.id
  type     = "A"
  data     = kubernetes_ingress_v1.app_ingress.status[0].load_balancer[0].ingress[0].ip
  ttl      = 3600

  depends_on = [
    kubernetes_ingress_v1.app_ingress
  ]
}
