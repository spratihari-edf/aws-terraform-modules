resource "aws_dynamodb_table" "ddb_table" {
  name           = local.name
  read_capacity  = var.read_capacity
  write_capacity = var.write_capacity
  hash_key       = var.hash_key_name

  attribute {
    name = "LockID"
    type = "S"
  }

  server_side_encryption {
    enabled     = "true"
    kms_key_arn = local.kms_arn
  }
  tags = module.tags.tags
}
