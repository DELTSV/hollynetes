resource "helm_release" "kube-prometheus" {
  name       = "kube-prometheus-stack"
  namespace  = "prometheus"
  version    = "55.0.0"
  repository = "https://prometheus-community.github.io/helm-charts"
  chart      = "kube-prometheus-stack"
  create_namespace = true
}
