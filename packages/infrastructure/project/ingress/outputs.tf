output "ingress_ip" {
  value = kubernetes_ingress_v1.app_ingress.status[0].load_balancer[0].ingress[0].ip
}
