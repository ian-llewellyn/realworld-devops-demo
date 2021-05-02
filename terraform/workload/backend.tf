resource "helm_release" "backend" {
  name  = "api"
  chart = "${path.module}/charts/backend"

  atomic          = true
  cleanup_on_fail = true

  values = [
    file("${path.module}/backend-values.yaml")
  ]

  set {
    name  = "ingress.hosts[0].host"
    value = join(".", [var.api_hostname, var.domain])
  }

  set {
    name  = "ingress.hosts[0].paths[0].path"
    value = "/api(/*|$)(.*)"
  }

  set {
    name  = "ingress.tls[0].hosts[0]"
    value = join(".", [var.api_hostname, var.domain])
  }

  set {
    name  = "ingress.tls[0].secretName"
    value = join("-", [join(".", [var.api_hostname, var.domain]), "tls"])
  }

  depends_on = [
    helm_release.database
  ]
}
