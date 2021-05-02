variable "domain" {
  description = "The domain into which Grafana will be installed"
  type        = string
  default     = "local"
}

variable "hostname" {
  description = "The host part of the FQDN that will be used for Grafana UI"
  type        = string
  default     = "grafana"
}
