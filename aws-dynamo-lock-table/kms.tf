resource "aws_kms_key" "key" {
  count               = local.create_kms_key
  description         = "KMS Key for ${local.name} dynamodb"
  enable_key_rotation = true
  policy              = var.policy
  tags                = module.tags.tags
}

resource "aws_kms_alias" "alias" {
  count         = var.alias == "" ? 0 : 1
  name          = "alias/${var.alias}"
  target_key_id = aws_kms_key.key[count.index].key_id
}
