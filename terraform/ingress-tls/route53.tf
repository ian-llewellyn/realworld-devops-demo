# Get the DNS hostname for the ELB
data "kubernetes_service" "ingress_controller" {
  metadata {
    name = "nginx-ingress-controller"
  }

  depends_on = [
    helm_release.ingress_controller
  ]
}

resource "aws_route53_record" "wildcard" {
  zone_id = var.zone_id
  name    = join(".", ["*", var.domain])
  type    = "CNAME"
  ttl     = "300"
  records = [data.kubernetes_service.ingress_controller.status.0.load_balancer.0.ingress.0.hostname]
}
