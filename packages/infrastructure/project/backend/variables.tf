variable "image" {
  type = string
  description = "Docker image to deploy"
}

variable "tmdb_api_key" {
  type = string
  description = "API key for TMDB"
}

variable "google_auth_client_id" {
    type = string
    description = "Google OAuth Client ID"
}

variable "google_auth_client_secret" {
    type = string
    description = "Google OAuth Client Secret"
}

variable "admin_password" {
    type = string
    description = "Admin password for the application"
}

variable "mongo_root_password" {
    type = string
    description = "MongoDB root password"
}

variable "jwt_secret" {
    type = string
    description = "JWT secret"
}

variable "database_dns_name" {
    type = string
    description = "DNS name for the database"
}
