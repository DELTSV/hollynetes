data "scaleway_domain_zone" "hollynetes" {
  domain = var.domain_name
}

resource "scaleway_domain_record" "hollynetes" {
  dns_zone = data.scaleway_domain_zone.hollynetes.id
  type     = "A"
  data     = module.ingress.ingress_ip
  ttl      = 3600

  depends_on = [
    module.ingress
  ]
}
