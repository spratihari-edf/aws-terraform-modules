provider "aws" {
  region = "eu-west-1"
}

module "s3-private" {
  source          = "../"
  name            = "some-private-bucket-name-for-testing"
  prevent_destroy = false
  tags_override   = var.tags
}

output "s3-private" {
  value = module.s3-private
}

variable "name" {
  default = "some-privatebucket-bucketpolicy-for-testing"
}

module "s3-private-withbucketpolicy" {
  source               = "../"
  name                 = var.name
  override_bucket_name = true
  prevent_destroy      = false
  acl                  = "log-delivery-write"
  bucket_policy        = data.aws_iam_policy_document.logbucketpolicy.json
  tags_override        = var.tags
}

data "aws_iam_policy_document" "logbucketpolicy" {
  statement {
    sid = "AWSCloudTrailAclCheck"
    principals {
      type        = "Service"
      identifiers = ["cloudtrail.amazonaws.com"]
    }
    actions = [
      "s3:GetBucketAcl",
    ]

    resources = [
      "arn:aws:s3:::${var.name}"
    ]
  }

  statement {
    sid = "AWSCloudTrailWrite"
    actions = [
      "s3:PutObject"
    ]
    principals {
      type        = "Service"
      identifiers = ["cloudtrail.amazonaws.com"]
    }
    resources = [
      "arn:aws:s3:::${var.name}/AWSLogs/*"
    ]

    condition {
      test     = "StringEquals"
      variable = "s3:x-amz-acl"

      values = [
        "bucket-owner-full-control"
      ]
    }
  }
}

module "s3-private-with-cors-compulsory" {
  source          = "../"
  name            = "test-bucket-with-some-cors"
  prevent_destroy = false

  cors_rules = [
    {
      allowed_methods = ["GET", "PUT"]
      allowed_origins = ["https://dummy.localhost", "https://dummy2.localhost"]
      allowed_headers = null
      expose_headers  = null
      max_age_seconds = null
    },
    {
      allowed_methods = ["GET"]
      allowed_origins = ["https://dummy3.localhost"]
      allowed_headers = null
      expose_headers  = null
      max_age_seconds = null
    }
  ]
  tags_override = var.tags
}

module "s3-private-with-cors-all" {
  source          = "../"
  name            = "test-bucket-with-all-cors"
  prevent_destroy = false

  cors_rules = [
    {
      allowed_methods = ["GET"]
      allowed_origins = ["https://dummy3.localhost"]
      allowed_headers = ["dummy-allowed-header", "another-allowed"]
      expose_headers  = ["dummy-header", "another-dummy"]
      max_age_seconds = 300
    }
  ]
  tags_override = var.tags
}

module "test-key" {
  source        = "../../aws-kms"
  name          = "test"
  description   = "test"
  tags_override = var.tags
}

module "s3-with-kms-key-object" {
  source          = "../"
  name            = "test-bucket-with-kms-key-object"
  prevent_destroy = false
  kms_key         = module.test-key.kms_key
  tags_override   = var.tags
}

output "s3-with-kms-key-object" {
  value = module.s3-with-kms-key-object
}

module "s3-with-standard-lifecycles" {
  source                               = "../"
  name                                 = "test-bucket-with-standard-lifecycles"
  prevent_destroy                      = false
  kms_key                              = module.test-key.kms_key
  tags_override                        = var.tags
  lifecycle_ia_transition_enabled      = true
  lifecycle_days_to_ia_transition      = 30
  lifecycle_glacier_transition_enabled = false
  lifecycle_days_to_glacier_transition = 60
  lifecycle_expiration_enabled         = true
  lifecycle_days_to_expiration         = 90
}

output "s3-with-standard-lifecycle" {
  value = module.s3-with-standard-lifecycles
}

module "s3-with-versions-lifecycles" {
  source          = "../"
  name            = "test-bucket-with-versions-lifecycles"
  prevent_destroy = false
  kms_key         = module.test-key.kms_key
  tags_override   = var.tags

  lifecycle_versions_ia_transition_enabled      = true
  lifecycle_versions_days_to_ia_transition      = 30
  lifecycle_versions_glacier_transition_enabled = false
  lifecycle_versions_days_to_glacier_transition = 60
  lifecycle_versions_expiration_enabled         = true
  lifecycle_versions_days_to_expiration         = 90
}

output "s3-with-versions-lifecycle" {
  value = module.s3-with-versions-lifecycles
}

module "s3-with-custom-lifecycle" {
  source          = "../"
  name            = "test-bucket-with-lifecycle-rules"
  prevent_destroy = false
  kms_key         = module.test-key.kms_key
  tags_override   = var.tags

  bucket_key_enabled  = true

  custom_lifecycle_rules = [
    {
      id      = "custom_rule"
      enabled = false
      prefix  = null
      expiration = {
        days = 10
      }
      transition                    = null
      noncurrent_version_expiration = null
      noncurrent_version_transition = null
    },
    {
      id         = null
      enabled    = false
      prefix     = null
      expiration = null
      transition = {
        days          = 30
        storage_class = "STANDARD_IA"
      }
      noncurrent_version_expiration = null
      noncurrent_version_transition = null
    },
    {
      id      = "expire-and-transition"
      enabled = true
      prefix  = null
      expiration = {
        days = 60
      }
      transition = {
        days          = 30
        storage_class = "STANDARD_IA"
      }
      noncurrent_version_expiration = null
      noncurrent_version_transition = null
    },
    {
      id      = null
      enabled = true
      prefix  = "test/"
      expiration = {
        days = 10
      }
      transition                    = null
      noncurrent_version_expiration = null
      noncurrent_version_transition = null
    },
    {
      id      = "noncurrent_expiration"
      enabled = true
      prefix  = "test/"
      expiration = {
        days = 10
      }
      transition = null
      noncurrent_version_expiration = {
        days = 25
      }
      noncurrent_version_transition = null
    },
    {
      id      = null
      enabled = true
      prefix  = "test/"
      expiration = {
        days = 10
      }
      transition                    = null
      noncurrent_version_expiration = null
      noncurrent_version_transition = {
        days          = 30
        storage_class = "STANDARD_IA"
      }
    },
    {
      id      = null
      enabled = true
      prefix  = "test/"
      expiration = {
        days = 10
      }
      transition = null
      noncurrent_version_transition = {
        days          = 30
        storage_class = "STANDARD_IA"
      }
      noncurrent_version_expiration = {
        days = 60
      }
    }
  ]
}
output "s3-with-custom-lifecycle" {
  value = module.s3-with-custom-lifecycle
}

variable "tags" {
  type = map(string)
  default = {
    "Cost Centre"    = "1234"
    "Major Function" = "Customers"
    "Project"        = "Test"
    "Service"        = "EIT"
    "Work Order"     = "1234"
  }
}
