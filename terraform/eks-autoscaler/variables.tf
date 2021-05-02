variable "cluster_name" {
  description = "The cluster to which IAM roles/policies should be associated"
  type        = string
}

variable "cluster_oidc_issuer_url" {
  description = "The OIDC Issuer URL associated with the cluster"
  type        = string
}

variable "autoscaler_controller_namespace" {
  description = "The namespace in which to place the autoscaler service account"
  type        = string
  default     = "kube-system"
}

variable "autoscaler_controller_service_account_name" {
  description = "The name of the autoscaler service account"
  type        = string
  default     = "asg-controller-aws-cluster-autoscaler"
}

variable "region" {
  description = "The AWS region for these terraform operations"
  type        = string
}
