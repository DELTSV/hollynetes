variable "access_key_id" {
  description = "Scaleway access key"
  type        = string
  sensitive   = true
}

variable "secret_key" {
  description = "Scaleway secret key"
  type        = string
  sensitive   = true
}

variable "project_id" {
  type        = string
  description = "Your project ID."
}

variable "domain_name" {
  type        = string
  default     = "hollynetes.fr"
  description = "Domain name to use for the cluster."
}

variable "backend_image" {
  type        = string
  default     = "rg.fr-par.scw.cloud/app-namespace/backend:latest"
  description = "Backend image tag to use."
}

variable "frontend_image" {
  type        = string
  default     = "rg.fr-par.scw.cloud/app-namespace/frontend:latest"
  description = "Frontend image tag to use."
}

variable "backend_tmdb_api_key" {
  type        = string
  description = "TMDB API key"
  sensitive   = true
}

variable "backend_admin_password" {
  type        = string
  description = "Admin password"
  sensitive   = true
}

variable "backend_google_auth_client_id" {
  type        = string
  description = "Google Auth client ID"
  sensitive   = true
}

variable "backend_google_auth_client_secret" {
  type        = string
  description = "Google Auth client secret"
  sensitive   = true
}

variable "mongo_root_password" {
  type        = string
  description = "Mongo root password"
  sensitive   = true
}

variable "backend_jwt_secret" {
  type      = string
  sensitive = true
}

variable "redis_password" {
  type        = string
  description = "Redis password"
  sensitive   = true
}

variable "issuer_email" {
  type        = string
  description = "Email address to use for the certificate issuer."
  sensitive   = true
}
