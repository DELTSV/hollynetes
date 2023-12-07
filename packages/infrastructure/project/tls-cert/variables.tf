variable "issuer_name" {
  type = string
  default = "letsencrypt-cluster-issuer"
  description = "The name of the cluster issuer"
}

variable "private_key_secret_name" {
  type = string
  default = "letsencrypt-cert-private-key"
  description = "The name of the secret containing the private key"
}

variable "issuer_email" {
  type = string
  description = "The email address to use for the certificate"
}
