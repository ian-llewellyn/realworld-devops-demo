resource "helm_release" "cert_manager" {
  name             = "cert-manager"
  repository       = "https://charts.jetstack.io"
  chart            = "cert-manager"
  version          = "v1.3.0"
  namespace        = "cert-manager"
  create_namespace = true

  atomic          = true
  cleanup_on_fail = true

  set {
    name  = "installCRDs"
    value = "true"
  }

  set {
    name  = "ingressShim.defaultIssuerName"
    value = var.cert_issuer_name
  }

  set {
    name  = "ingressShim.defaultIssuerKind"
    value = "ClusterIssuer"
  }

  set {
    name  = "ingressShim.defaultIssuerGroup"
    value = "cert-manager.io"
  }

  #depends_on = [ # Only depends on this to issue certificates, not to be running and ready
  #  aws_route53_record.wildcard
  #]
}
