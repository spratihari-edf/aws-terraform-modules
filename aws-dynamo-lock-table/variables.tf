variable "name" {
  description = "The DynamoDB table name."
  type        = string
}

variable "read_capacity" {
  description = "The read capacity, in units, of the DynamoDB table."
  type        = string
  default     = 1
}

variable "write_capacity" {
  description = "The write capacity, in units, of the DynamoDB table."
  type        = string
  default     = 1
}

variable "hash_key_name" {
  description = "The primary/partition key name of the DynamoDB table."
  type        = string
  default     = "LockID"
}

variable "kms_arn" {
  description = "The arn of the kms key created for encrypting the DynamoDB"
  type        = string
  default     = ""
}

variable "environment" {
  description = "Environment definition for the kms (dev,prod)"
  default     = "dev"
}

variable "project" {
  default     = "eit"
  description = "This is the project name for which KMS will be created"
}

variable "policy" {
  description = "Policy applied to the key"
  default     = null
}

variable "alias" {
  description = "This is the alias name of KMS key. This must be unique in the account, eg: bucketkey,EBSKey,DynamoDBKey,Myownkey"
  default     = ""
}

variable "tags_override" {
  type        = map(string)
  description = "A custom map of tags to override default tags"
  default     = {}
}
