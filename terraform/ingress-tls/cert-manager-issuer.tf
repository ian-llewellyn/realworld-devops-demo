resource "helm_release" "cert_manager_issuer" {
  name  = "cert-manager-basic-acme-issuer"
  chart = "${path.module}/charts/cert-manager-basic-acme-issuer"

  atomic          = true
  cleanup_on_fail = true

  set {
    name  = "email"
    value = var.cm_email
  }

  set {
    name  = "domain"
    value = var.domain
  }

  set {
    name  = "issuerName"
    value = var.cert_issuer_name
  }

  set {
    name  = "staging"
    value = var.staging
  }

  depends_on = [
    helm_release.cert_manager
  ]
}
