variable "domain" {
  description = "The DNS zone in which these resources will be placed"
  type        = string
  #default     = ""
}

variable "api_hostname" {
  description = "The host part of the API FQDN - api by default"
  type        = string
  default     = "api"
}

variable "ui_hostname" {
  description = "The host part of the frontend's FQDN - www by default"
  type        = string
  default     = "www"
}
