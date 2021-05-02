variable "region" {
  description = "The AWS location in which to operate this terraform project"
  default     = "us-west-2"
}

variable "create_cluster" {
  description = "Option to skip cluster creation"
  type        = bool
  default     = true
}

variable "cluster_infra_prefix" {
  description = "Prefix for infrastructure created for this cluster"
  type        = string
  default     = "realworld"
}

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

variable "zone_id" {
  description = "AWS Zone ID for the DNS zone that will have its root and wildcard records updated"
  type        = string
}

variable "cicd_hostname" {
  description = "The host part of the FQDN (which will be constructed) for the CI/CD system"
  default     = "cicd"
  type        = string
}

variable "cicd_password" {
  description = "The password to use for Jenkins - can be left blank on first `apply`"
  default     = ""
  type        = string
}

variable "extra_monitoring" {
  description = "Turn on extra infrastructure metrics - ingress-controller, cert-manager"
  type        = bool
  default     = false
}
