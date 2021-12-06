locals {
  name           = "${var.name}-${var.environment}-${module.common.aws_account_id}"
  create_kms_key = var.kms_arn == "" ? 1 : 0
  kms_arn = local.create_kms_key == 1 ? aws_kms_key.key[0].arn : var.kms_arn
}