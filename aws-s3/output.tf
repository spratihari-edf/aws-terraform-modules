output "bucket" {
  # Output either the prod or the dev bucket resource
  # depends on var.prevent_destroy
  value = coalescelist(
    aws_s3_bucket.s3_bucket_prod.*,
    aws_s3_bucket.s3_bucket_dev.*
  )[0]
}

output "kms_key" {
  value = local.kms_key
}
