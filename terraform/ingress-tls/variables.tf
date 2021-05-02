variable "cm_email" {
  description = "The email address to use for LetsEncrypt CSRs"
  type        = string
}

variable "domain" {
  description = "The DNS Zone that cert-manager will handle CSRs for"
  type        = string
}

variable "staging" {
  description = "Enable certificate staging so that rate limits are not applied to requests"
  type        = bool
  default     = false
}

variable "cert_issuer_name" {
  description = "The name of the ClusterIssuer to be deployed and referenced by cert-manager's ingress-shim"
  default     = "letsencrypt-prod"
  type        = string
}

variable "zone_id" {
  description = "AWS Zone ID for the DNS zone that will have its root and wildcard records updated"
  type        = string
}

variable "monitoring" {
  description = "Switch on metrics endpoints and ServiceMonitor resources"
  type        = bool
  default     = false
}
