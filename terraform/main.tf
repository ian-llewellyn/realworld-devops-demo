module "cluster" {
  source = "./eks"

  create_eks   = var.create_cluster
  region       = var.region
  infra_prefix = var.cluster_infra_prefix
}

module "autoscaler" {
  source = "./eks-autoscaler"

  region                  = var.region
  cluster_name            = module.cluster.cluster_name
  cluster_oidc_issuer_url = module.cluster.cluster_oidc_issuer_url

  # Without the explicit dependency, this module tries to kick off before
  # module.eks.null_resource.wait_for_cluster[0]
  depends_on = [
    module.cluster
  ]
}

module "monitoring" {
  source = "./kps-loki"

  domain = var.domain

  # Small clusters can run out of pod allocation very quickly
  depends_on = [
    module.autoscaler
  ]
}

module "ingress_tls" {
  source = "./ingress-tls"

  zone_id    = var.zone_id
  cm_email   = var.cm_email
  domain     = var.domain
  staging    = var.staging
  monitoring = var.extra_monitoring

  # Create an explicit dependency in case ServiceMonitor CRD is required
  depends_on = [
    module.monitoring
  ]
}

module "workload" {
  source = "./workload"

  domain = var.domain

  # FIXME: Why is this dependency here - may not be necessary
  depends_on = [
    module.ingress_tls
  ]
}
