resource "helm_release" "kps" {
  name       = "kps"
  repository = "https://prometheus-community.github.io/helm-charts"
  chart      = "kube-prometheus-stack"
  version    = "14.6.2"

  atomic          = true
  cleanup_on_fail = true

  values = [
    file("${path.module}/kps-values.yaml")
  ]

  set {
    name  = "grafana.ingress.hosts[0]"
    value = join(".", [var.hostname, var.domain])
  }

  set {
    name  = "grafana.ingress.tls[0].hosts[0]"
    value = join(".", [var.hostname, var.domain])
  }

  set {
    name  = "grafana.ingress.tls[0].secretName"
    value = join("-", [join(".", [var.hostname, var.domain]), "tls"])
  }
}

resource "helm_release" "extra_dashboards" {
  name       = "dashboard"
  chart      = "${path.module}/charts/grafana-extra-dashboards"

  atomic          = true
  cleanup_on_fail = true
}
