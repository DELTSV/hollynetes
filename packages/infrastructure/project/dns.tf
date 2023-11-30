data "scaleway_domain_zone" "hollynetes" {
  domain    = "hollyfilms.fr"
}

resource "scaleway_domain_record" "hollynetes" {
  dns_zone = data.scaleway_domain_zone.hollynetes.id
  name     = "k8s"
  type     = "A"
  data     = kubernetes_ingress_v1.app_ingress.status[0].load_balancer[0].ingress[0].ip
  ttl      = 3600
}
