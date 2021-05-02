resource "helm_release" "loki" {
  name       = "loki"
  repository = "https://grafana.github.io/helm-charts"
  chart      = "loki-stack"
  version    = "2.3.1"

  atomic          = true
  cleanup_on_fail = true

  values = [
    file("${path.module}/loki-stack-values.yaml")
  ]

  depends_on = [
    helm_release.kps
  ]
}
