resource "helm_release" "database" {
  name  = "db"
  chart = "${path.module}/charts/database"

  atomic          = true
  cleanup_on_fail = true
}
