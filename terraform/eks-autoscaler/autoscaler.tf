data "aws_caller_identity" "current" {}

resource "helm_release" "autoscaler" {
  name       = "asg-controller"
  repository = "https://kubernetes.github.io/autoscaler"
  chart      = "cluster-autoscaler"
  version    = "9.9.2"

  namespace = var.autoscaler_controller_namespace

  set {
    name  = "awsRegion"
    value = var.region
  }

  set {
    name  = "rbac.serviceAccount.annotations.eks\\.amazonaws\\.com/role-arn"
    value = "arn:aws:iam::${data.aws_caller_identity.current.account_id}:role/cluster-autoscaler"
  }

  set {
    name  = "image.tag"
    value = "v1.19.1"
  }

  set { # Looking at the helm templates reveals that this parameter has to be present, but not necessarily correct
    name  = "autoDiscovery.clusterName"
    value = var.cluster_name
  }

  set { # This appears nowhere in the helm templates or values file
    name  = "autodiscovery.enabled"
    value = "true"
  }

  set {
    name  = "autoDiscovery.tags[0]"
    value = "k8s.io/cluster-autoscaler/enabled"
  }

  set {
    name  = "autoDiscovery.tags[1]"
    value = "k8s.io/cluster-autoscaler/${var.cluster_name}"
  }
}
