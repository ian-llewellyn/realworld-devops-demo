resource "aws_iam_role" "k8s_pv_backup" {
  name               = "k8s_pv_backup_role"
  assume_role_policy = <<POLICY
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Action": ["sts:AssumeRole"],
      "Effect": "allow",
      "Principal": {
        "Service": ["backup.amazonaws.com"]
      }
    }
  ]
}
POLICY
}

resource "aws_iam_role_policy_attachment" "k8s_pv_backup" {
  policy_arn = "arn:aws:iam::aws:policy/service-role/AWSBackupServiceRolePolicyForBackup"
  role       = aws_iam_role.k8s_pv_backup.name
}

resource "aws_backup_vault" "default_namespace" {
  name = "k8s_pv_default_ns"
}

resource "aws_backup_plan" "default_namespace" {
  name = "k8s_pv_backup_plan"

  rule {
    rule_name         = "k8s_default_ns_backup_rule"
    target_vault_name = aws_backup_vault.default_namespace.name
    schedule          = "cron(0 12 * * ? *)"

    lifecycle {
      delete_after = 2
    }
  }
}

resource "aws_backup_selection" "default_namespace" {
  iam_role_arn = aws_iam_role.k8s_pv_backup.arn
  name         = "k8s_default_ns_backup_selection"
  plan_id      = aws_backup_plan.default_namespace.id

  selection_tag {
    type  = "STRINGEQUALS"
    key   = "kubernetes.io/created-for/pvc/namespace"
    value = "default"
  }
}
