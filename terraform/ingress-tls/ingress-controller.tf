resource "helm_release" "ingress_controller" {
  name       = "nginx-ingress-controller"
  repository = "https://kubernetes.github.io/ingress-nginx"
  chart      = "ingress-nginx"
  version    = "3.29.0"

  atomic          = true
  cleanup_on_fail = true

  values = [
    file("${path.module}/ingress-nginx-values.yaml")
  ]
}
