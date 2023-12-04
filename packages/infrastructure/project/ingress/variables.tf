variable "domain_name" {
  type      = string
  description = "The domain name to use for the cluster"
}

variable "backend_service_name" {
  type      = string
  description = "The name of the backend service"
}

variable "frontend_service_name" {
  type      = string
  description = "The name of the backend service"
}

variable "backend_service_port" {
  type      = number
  description = "The port to use for the backend service"
}

variable "frontend_service_port" {
  type      = number
  description = "The port to use for the frontend service"
}
