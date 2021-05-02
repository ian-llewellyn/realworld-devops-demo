resource "helm_release" "frontend" {
  name  = "ui"
  chart = "${path.module}/charts/frontend"

  atomic          = true
  cleanup_on_fail = true

  set {
    name  = "ingress.hosts[0].host"
    value = join(".", [var.ui_hostname, var.domain])
  }

  set {
    name  = "ingress.hosts[0].paths[0].path"
    value = "/"
  }

  set {
    name  = "ingress.tls[0].hosts[0]"
    value = join(".", [var.ui_hostname, var.domain])
  }

  set {
    name  = "ingress.tls[0].secretName"
    value = join("-", [join(".", [var.ui_hostname, var.domain]), "tls"])
  }

  set {
    name  = "restURL"
    value = join("", ["https://", join(".", [var.api_hostname, var.domain]), "/api"])
  }

  depends_on = [
    helm_release.backend
  ]
}
