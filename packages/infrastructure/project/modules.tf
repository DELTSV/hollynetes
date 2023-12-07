module "ingress" {
  source                           = "./ingress"
  backend_service_name             = module.backend.service_name
  backend_service_port             = module.backend.service_port
  domain_name                      = var.domain_name
  frontend_service_name            = module.frontend.service_name
  frontend_service_port            = module.frontend.service_port
  tls_cert_private_key_secret_name = module.tls_cert.private_key_secret_name
  tls_cert_issuer_name             = module.tls_cert.issuer_name

  depends_on = [
    module.backend,
    module.frontend,
    module.tls_cert,
  ]
}

module "backend" {
  source = "./backend"

  image                           = var.backend_image
  tmdb_api_key                    = var.backend_tmdb_api_key
  google_auth_client_id           = var.backend_google_auth_client_id
  google_auth_client_secret       = var.backend_google_auth_client_secret
  admin_password                  = var.backend_admin_password
  jwt_secret                      = var.backend_jwt_secret
  database_dns_name               = module.database.dns_name
  redis_password_secret_name      = module.cache.redis_password_secret_name
  mongo_root_password_secret_name = module.database.mongodb_root_password_secret_name
  cache_dns_name                  = module.cache.dns_name

  depends_on = [
    module.kapsule,
  ]
}

module "frontend" {
  source = "./frontend"

  image = var.frontend_image

  depends_on = [
    module.kapsule,
  ]
}

module "database" {
  source = "./database"

  mongo_root_password = var.mongo_root_password

  depends_on = [
    module.kapsule,
  ]
}

module "kapsule" {
  source = "./kapsule"
}

module "tls_cert" {
  source = "./tls-cert"

  depends_on = [
    module.kapsule,
  ]
}

module "metrics_logs" {
  source = "./metrics-logs"

  depends_on = [
    module.kapsule,
  ]
}

module "cache" {
  source   = "./cache"
  password = var.redis_password

  depends_on = [
    module.kapsule,
  ]
}
