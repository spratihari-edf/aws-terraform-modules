resource "aws_s3_bucket" "s3_bucket_dev" {
  count         = var.prevent_destroy == true ? 0 : 1
  bucket        = local.name
  acl           = var.acl
  policy        = var.bucket_policy
  force_destroy = var.force_destroy

  versioning {
    enabled    = true
    mfa_delete = var.mfa_delete
  }

  server_side_encryption_configuration {
    rule {
      apply_server_side_encryption_by_default {
        kms_master_key_id = local.kms_key.arn
        sse_algorithm     = "aws:kms"
      }
      bucket_key_enabled = var.bucket_key_enabled
    }
  }

  lifecycle {
    prevent_destroy = false
  }

  dynamic "lifecycle_rule" {
    for_each = var.lifecycle_ia_transition_enabled ? [1] : []
    content {
      id      = "transition-to-ia"
      enabled = var.lifecycle_ia_transition_enabled

      transition {
        days          = var.lifecycle_days_to_ia_transition
        storage_class = "STANDARD_IA"
      }
    }
  }

  dynamic "lifecycle_rule" {
    for_each = var.lifecycle_glacier_transition_enabled ? [1] : []
    content {
      id      = "transition-to-glacier"
      enabled = var.lifecycle_glacier_transition_enabled

      transition {
        days          = var.lifecycle_days_to_glacier_transition
        storage_class = "GLACIER"
      }
    }
  }

  dynamic "lifecycle_rule" {
    for_each = var.lifecycle_expiration_enabled ? [1] : []
    content {
      id      = "expiration"
      enabled = var.lifecycle_expiration_enabled

      expiration {
        days = var.lifecycle_days_to_expiration
      }
    }
  }

  /* non current versions */
  dynamic "lifecycle_rule" {
    for_each = var.lifecycle_versions_ia_transition_enabled ? [1] : []
    content {
      id      = "noncurrent-versions-transition-to-ia"
      enabled = var.lifecycle_versions_ia_transition_enabled

      noncurrent_version_transition {
        days          = var.lifecycle_versions_days_to_ia_transition
        storage_class = "STANDARD_IA"
      }
    }
  }

  dynamic "lifecycle_rule" {
    for_each = var.lifecycle_versions_glacier_transition_enabled ? [1] : []
    content {
      id      = "noncurrent-versions-transition-to-glacier"
      enabled = var.lifecycle_versions_glacier_transition_enabled

      noncurrent_version_transition {
        days          = var.lifecycle_versions_days_to_glacier_transition
        storage_class = "GLACIER"
      }
    }
  }

  dynamic "lifecycle_rule" {
    for_each = var.lifecycle_versions_expiration_enabled ? [1] : []
    content {
      id      = "noncurrent-versions-expiration"
      enabled = var.lifecycle_versions_expiration_enabled

      noncurrent_version_expiration {
        days = var.lifecycle_versions_days_to_expiration
      }
    }
  }

  dynamic "lifecycle_rule" {

    for_each = var.custom_lifecycle_rules
    content {

      id      = lifecycle_rule.value.id != null ? lifecycle_rule.value.id : "custom-lifecycle-rule-${lifecycle_rule.key + 1}"
      enabled = lifecycle_rule.value.enabled

      prefix = lookup(lifecycle_rule.value, "prefix", null)

      dynamic "expiration" {
        for_each = lifecycle_rule.value.expiration != null ? [lifecycle_rule.value.expiration] : []
        content {
          days = lookup(expiration.value, "days", null)
        }
      }

      dynamic "noncurrent_version_expiration" {
        for_each = lifecycle_rule.value.noncurrent_version_expiration != null ? [lifecycle_rule.value.noncurrent_version_expiration] : []
        content {
          days = lookup(noncurrent_version_expiration.value, "days", null)
        }
      }

      dynamic "transition" {
        for_each = lifecycle_rule.value.transition != null ? [lifecycle_rule.value.transition] : []
        content {
          days          = lookup(transition.value, "days", null)
          storage_class = lookup(transition.value, "storage_class", null)
        }
      }
      dynamic "noncurrent_version_transition" {
        for_each = lifecycle_rule.value.noncurrent_version_transition != null ? [lifecycle_rule.value.noncurrent_version_transition] : []
        content {
          days          = lookup(noncurrent_version_transition.value, "days", null)
          storage_class = lookup(noncurrent_version_transition.value, "storage_class", null)
        }
      }
    }

  }

  dynamic "cors_rule" {
    for_each = var.cors_rules
    content {
      allowed_headers = cors_rule.value.allowed_headers
      allowed_methods = cors_rule.value.allowed_methods
      allowed_origins = cors_rule.value.allowed_origins
      expose_headers  = cors_rule.value.expose_headers
      max_age_seconds = cors_rule.value.max_age_seconds
    }
  }

  dynamic "logging" {
    for_each = var.logging_target_bucket_name != null ? [1] : []
    content {
      target_bucket = var.logging_target_bucket_name
      target_prefix = var.logging_target_prefix
    }
  }

  tags = module.tags.tags
}

resource "aws_s3_bucket" "s3_bucket_prod" {
  count  = var.prevent_destroy == true ? 1 : 0
  bucket = local.name
  acl    = var.acl
  policy = var.bucket_policy

  versioning {
    enabled    = true
    mfa_delete = var.mfa_delete
  }

  server_side_encryption_configuration {
    rule {
      apply_server_side_encryption_by_default {
        kms_master_key_id = local.kms_key.arn
        sse_algorithm     = "aws:kms"
      }
      bucket_key_enabled = var.bucket_key_enabled
    }
  }

  lifecycle {
    prevent_destroy = true
  }

  dynamic "lifecycle_rule" {
    for_each = var.lifecycle_ia_transition_enabled ? [1] : []
    content {
      id      = "transition-to-ia"
      enabled = var.lifecycle_ia_transition_enabled

      transition {
        days          = var.lifecycle_days_to_ia_transition
        storage_class = "STANDARD_IA"
      }
    }
  }

  dynamic "lifecycle_rule" {
    for_each = var.lifecycle_glacier_transition_enabled ? [1] : []
    content {
      id      = "transition-to-glacier"
      enabled = var.lifecycle_glacier_transition_enabled

      transition {
        days          = var.lifecycle_days_to_glacier_transition
        storage_class = "GLACIER"
      }
    }
  }

  dynamic "lifecycle_rule" {
    for_each = var.lifecycle_expiration_enabled ? [1] : []
    content {
      id      = "expiration"
      enabled = var.lifecycle_expiration_enabled

      expiration {
        days = var.lifecycle_days_to_expiration
      }
    }
  }

  /* non current versions */
  dynamic "lifecycle_rule" {
    for_each = var.lifecycle_versions_ia_transition_enabled ? [1] : []
    content {
      id      = "noncurrent-versions-transition-to-ia"
      enabled = var.lifecycle_versions_ia_transition_enabled

      noncurrent_version_transition {
        days          = var.lifecycle_versions_days_to_ia_transition
        storage_class = "STANDARD_IA"
      }
    }
  }

  dynamic "lifecycle_rule" {
    for_each = var.lifecycle_versions_glacier_transition_enabled ? [1] : []
    content {
      id      = "noncurrent-versions-transition-to-glacier"
      enabled = var.lifecycle_versions_glacier_transition_enabled

      noncurrent_version_transition {
        days          = var.lifecycle_versions_days_to_glacier_transition
        storage_class = "GLACIER"
      }
    }
  }

  dynamic "lifecycle_rule" {
    for_each = var.lifecycle_versions_expiration_enabled ? [1] : []
    content {
      id      = "noncurrent-versions-expiration"
      enabled = var.lifecycle_versions_expiration_enabled

      noncurrent_version_expiration {
        days = var.lifecycle_versions_days_to_expiration
      }
    }
  }

  dynamic "lifecycle_rule" {

    for_each = var.custom_lifecycle_rules
    content {

      id      = lifecycle_rule.value.id != null ? lifecycle_rule.value.id : "custom-lifecycle-rule-${lifecycle_rule.key + 1}"
      enabled = lifecycle_rule.value.enabled

      prefix = lookup(lifecycle_rule.value, "prefix", null)

      dynamic "expiration" {
        for_each = lifecycle_rule.value.expiration != null ? [lifecycle_rule.value.expiration] : []
        content {
          days = lookup(expiration.value, "days", null)
        }
      }

      dynamic "noncurrent_version_expiration" {
        for_each = lifecycle_rule.value.noncurrent_version_expiration != null ? [lifecycle_rule.value.noncurrent_version_expiration] : []
        content {
          days = lookup(noncurrent_version_expiration.value, "days", null)
        }
      }

      dynamic "transition" {
        for_each = lifecycle_rule.value.transition != null ? [lifecycle_rule.value.transition] : []
        content {
          days          = lookup(transition.value, "days", null)
          storage_class = lookup(transition.value, "storage_class", null)
        }
      }
      dynamic "noncurrent_version_transition" {
        for_each = lifecycle_rule.value.noncurrent_version_transition != null ? [lifecycle_rule.value.noncurrent_version_transition] : []
        content {
          days          = lookup(noncurrent_version_transition.value, "days", null)
          storage_class = lookup(noncurrent_version_transition.value, "storage_class", null)
        }
      }
    }

  }

  dynamic "cors_rule" {
    for_each = var.cors_rules
    content {
      allowed_headers = cors_rule.value.allowed_headers
      allowed_methods = cors_rule.value.allowed_methods
      allowed_origins = cors_rule.value.allowed_origins
      expose_headers  = cors_rule.value.expose_headers
      max_age_seconds = cors_rule.value.max_age_seconds
    }
  }

  dynamic "logging" {
    for_each = var.logging_target_bucket_name != null ? [1] : []
    content {
      target_bucket = var.logging_target_bucket_name
      target_prefix = var.logging_target_prefix
    }
  }

  tags = module.tags.tags
}

# block all public access as best practice
resource "aws_s3_bucket_public_access_block" "public_access_block" {
  bucket = var.prevent_destroy == true ? aws_s3_bucket.s3_bucket_prod[0].id : aws_s3_bucket.s3_bucket_dev[0].id

  # Block new public ACLs and uploading public objects
  block_public_acls = true

  # Retroactively remove public access granted through public ACLs
  ignore_public_acls = true

  # Block new public bucket policies
  block_public_policy = true

  # Retroactivley block public and cross-account access if bucket has public policies
  restrict_public_buckets = true
}
