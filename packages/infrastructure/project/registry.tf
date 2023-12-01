resource "scaleway_registry_namespace" "app_namespace" {
  name        = "app-namespace"
  description = "App registry namespace"
  is_public   = false
}
