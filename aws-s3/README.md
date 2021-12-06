<!-- BEGINNING OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
## Providers

| Name | Version |
|------|---------|
| aws | n/a |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| acl | Canned ACLs to be applied to bucket | `string` | `"private"` | no |
| bucket\_key\_enabled | Whether or not to use Amazon S3 Bucket Keys for SSE-KMS | `bool` | `false` | no |
| bucket\_policy | Policy applied to the bucket to manage restricted access | `any` | n/a | yes |
| compliance | Compliance that the bucket follows. Can be either `GDPR`, `PCI` or `Edf Standard` | `string` | `"GDPR"` | no |
| cors\_rules | The Cross-Origin Resource Sharing rules to apply to the bucket | <pre>list(<br>    object({<br>      allowed_headers = list(string)<br>      allowed_methods = list(string)<br>      allowed_origins = list(string)<br>      expose_headers  = list(string)<br>      max_age_seconds = number<br>    })<br>  )</pre> | `[]` | no |
| custom\_lifecycle\_rules | Specify additional lifecycle rules for the bucket e.g. Prefix specific | <pre>list(object({<br>    id      = string<br>    enabled = bool<br>    prefix  = string<br>    expiration = object({<br>      days = number<br>    })<br>    transition = object({<br>      days          = number<br>      storage_class = string<br>    })<br>    noncurrent_version_expiration = object({<br>      days = number<br>    })<br>    noncurrent_version_transition = object({<br>      days          = number<br>      storage_class = string<br>    })<br><br>  }))</pre> | `[]` | no |
| environment | Environment definition for the bucket (dev,prod) | `string` | `"dev"` | no |
| force\_destroy | The flag that defines if a non-empty S3 Bucket is allowed to be destroyed or it has previous versions | `bool` | `false` | no |
| kms\_key | The KMS Key Object that will be used for the Bucket. (A new one will be created if not supplied) | `map` | `{}` | no |
| kms\_key\_policy | Policy applied to the key used to encrypt the raw data bucket | `any` | n/a | yes |
| lifecycle\_days\_to\_expiration | Specifies the number of days after object creation when it will be Expired. | `any` | n/a | yes |
| lifecycle\_days\_to\_glacier\_transition | Specifies the number of days after object creation when it will be moved to Glacier storage. | `string` | `"365"` | no |
| lifecycle\_days\_to\_ia\_transition | Specifies the number of days after object creation when it will be moved to standard infrequent access storage. | `string` | `"180"` | no |
| lifecycle\_expiration\_enabled | Specifies Expiration lifecycle rule status. | `string` | `"false"` | no |
| lifecycle\_glacier\_transition\_enabled | Specifies Glacier transition lifecycle rule status. | `string` | `"false"` | no |
| lifecycle\_ia\_transition\_enabled | Specifies infrequent storage transition lifecycle rule status. | `string` | `"false"` | no |
| lifecycle\_versions\_days\_to\_expiration | Specifies the number of days after object version creation when it will be Expired. | `any` | n/a | yes |
| lifecycle\_versions\_days\_to\_glacier\_transition | Specifies the number of days after object version creation when it will be moved to Glacier storage. | `string` | `"365"` | no |
| lifecycle\_versions\_days\_to\_ia\_transition | Specifies the number of days after object version creation when it will be moved to standard infrequent access storage. | `string` | `"180"` | no |
| lifecycle\_versions\_expiration\_enabled | Specifies Expiration lifecycle rule status. | `string` | `"false"` | no |
| lifecycle\_versions\_glacier\_transition\_enabled | Specifies Glacier transition lifecycle rule status for versions. | `string` | `"false"` | no |
| lifecycle\_versions\_ia\_transition\_enabled | Specifies infrequent storage transition lifecycle rule status for versions. | `string` | `"false"` | no |
| logging\_target\_bucket\_name | Logging configuration: The name of the bucket that will receive the log objects. | `string` | `"null"` | no |
| logging\_target\_prefix | Logging configuration: To specify a key prefix for log objects. | `string` | `"null"` | no |
| mfa\_delete | The flag that defines if MFA authentication is required to execute any delete operations within S3 bucket and the objects | `bool` | `false` | no |
| name | The name of the bucket. Must follow [A-Za-z0-9\-]+ pattern. | `any` | n/a | yes |
| override\_bucket\_name | Flag to decide bucket name to be passed from variable or to be calculated in locals | `bool` | `false` | no |
| prevent\_destroy | The flag that defines if the S3 Bucket is allowed to be destroyed programmatically | `bool` | `true` | no |
| tags\_override | A custom map of tags to override default tags | `map(string)` | `{}` | no |

## Outputs

| Name | Description |
|------|-------------|
| bucket | n/a |
| kms\_key | n/a |

<!-- END OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
