variable "region" {
  description = "AWS region"
  type        = string
  default     = "us-east-2"
}

variable "create_eks" {
  description = "Switch on or off creation of the EKS cluster"
  type        = bool
  default     = true
}

variable "infra_prefix" {
  description = "Prefix for infrastructure created for this cluster"
  type        = string
  default     = "my-eks-cluster"
}
