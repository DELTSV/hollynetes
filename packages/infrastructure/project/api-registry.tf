resource "scaleway_registry_namespace" "api_namespace" {
  name        = "api-namespace"
  description = "api"
  is_public   = true
}

#data "scaleway_registry_image" "api_image" {
#  name         = "api-image"
#  namespace_id = scaleway_registry_namespace.api_namespace.id
#}
