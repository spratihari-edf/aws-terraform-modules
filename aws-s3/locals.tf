locals {
  name           = var.override_bucket_name ? lower(var.name) : lower("${var.name}-${var.environment}-${module.common.aws_account_id}")
  create_kms_key = var.kms_key == {} ? 1 : 0
  kms_key = coalescelist(
    aws_kms_key.key.*,
    data.aws_kms_key.key.*
  )[0]
}
