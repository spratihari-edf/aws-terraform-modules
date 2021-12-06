variable "name" {
  description = "The name of the bucket. Must follow [A-Za-z0-9\\-]+ pattern."
}

variable "environment" {
  description = "Environment definition for the bucket (dev,prod)"
  default     = "dev"
}

variable "kms_key" {
  description = "The KMS Key Object that will be used for the Bucket. (A new one will be created if not supplied)"
  default     = {}
}

variable "prevent_destroy" {
  description = "The flag that defines if the S3 Bucket is allowed to be destroyed programmatically"
  default     = true
}

variable "force_destroy" {
  description = "The flag that defines if a non-empty S3 Bucket is allowed to be destroyed or it has previous versions"
  default     = false
}

variable "mfa_delete" {
  description = "The flag that defines if MFA authentication is required to execute any delete operations within S3 bucket and the objects"
  default     = false
}

variable "lifecycle_ia_transition_enabled" {
  description = "Specifies infrequent storage transition lifecycle rule status."
  default     = "false"
}

variable "lifecycle_days_to_ia_transition" {
  description = "Specifies the number of days after object creation when it will be moved to standard infrequent access storage."
  default     = "180"
}

variable "lifecycle_glacier_transition_enabled" {
  description = "Specifies Glacier transition lifecycle rule status."
  default     = "false"
}

variable "lifecycle_days_to_glacier_transition" {
  description = "Specifies the number of days after object creation when it will be moved to Glacier storage."
  default     = "365"
}

variable "lifecycle_expiration_enabled" {
  description = "Specifies Expiration lifecycle rule status."
  default     = "false"
}

variable "lifecycle_days_to_expiration" {
  description = "Specifies the number of days after object creation when it will be Expired."
  default     = null
}

variable "lifecycle_versions_ia_transition_enabled" {
  description = "Specifies infrequent storage transition lifecycle rule status for versions."
  default     = "false"
}

variable "lifecycle_versions_days_to_ia_transition" {
  description = "Specifies the number of days after object version creation when it will be moved to standard infrequent access storage."
  default     = "180"
}

variable "lifecycle_versions_glacier_transition_enabled" {
  description = "Specifies Glacier transition lifecycle rule status for versions."
  default     = "false"
}

variable "lifecycle_versions_days_to_glacier_transition" {
  description = "Specifies the number of days after object version creation when it will be moved to Glacier storage."
  default     = "365"
}

variable "lifecycle_versions_expiration_enabled" {
  description = "Specifies Expiration lifecycle rule status."
  default     = "false"
}

variable "lifecycle_versions_days_to_expiration" {
  description = "Specifies the number of days after object version creation when it will be Expired."
  default     = null
}

variable "custom_lifecycle_rules" {
  description = "Specify additional lifecycle rules for the bucket e.g. Prefix specific"
  type = list(object({
    id      = string
    enabled = bool
    prefix  = string
    expiration = object({
      days = number
    })
    transition = object({
      days          = number
      storage_class = string
    })
    noncurrent_version_expiration = object({
      days = number
    })
    noncurrent_version_transition = object({
      days          = number
      storage_class = string
    })

  }))
  default = []
}

variable "kms_key_policy" {
  description = "Policy applied to the key used to encrypt the raw data bucket"
  default     = null
}

variable "bucket_policy" {
  description = "Policy applied to the bucket to manage restricted access"
  default     = null
}

variable "override_bucket_name" {
  description = "Flag to decide bucket name to be passed from variable or to be calculated in locals"
  default     = false
}

variable "cors_rules" {
  description = "The Cross-Origin Resource Sharing rules to apply to the bucket"
  type = list(
    object({
      allowed_headers = list(string)
      allowed_methods = list(string)
      allowed_origins = list(string)
      expose_headers  = list(string)
      max_age_seconds = number
    })
  )
  default = []
}

variable "compliance" {
  description = "Compliance that the bucket follows. Can be either `GDPR`, `PCI` or `Edf Standard`"
  default     = "GDPR"
}

variable "tags_override" {
  type        = map(string)
  description = "A custom map of tags to override default tags"
  default     = {}
}

variable "acl" {
  description = "Canned ACLs to be applied to bucket"
  default     = "private"
}

variable "bucket_key_enabled" {
  description = "Whether or not to use Amazon S3 Bucket Keys for SSE-KMS"
  default     = "false"
}

variable "logging_target_bucket_name" {
  description = "Logging configuration: The name of the bucket that will receive the log objects."
  default     = null
}

variable "logging_target_prefix" {
  description = "Logging configuration: To specify a key prefix for log objects."
  default     = null
}
