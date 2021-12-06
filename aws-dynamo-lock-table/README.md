# aws-dynamodb

# Module `./aws-dynamo-lock-table`

Core Version Constraints:
* `>= 0.12.3`

Provider Requirements:
* **aws:** (any version)

## Input Variables
* `name` (required): The descriptive component of the name. Environment and aws_account_id will be appended
* `read_capacity` (default `"1"`): The read capacity, in units, of the DynamoDB table.
* `write_capacity` (default `"1"`): The write capacity, in units, of the DynamoDB table.
* `hash_key_name` (default `"LockID"`): The primary/partition key name of the DynamoDB table.
* `kms_arn` (default ``): The arn of the kms key created for encrypting the DynamoDB.
* `environment` (default `"secondary"`): The environment definition for the Dynamodb to be created in (primary,secondary)
* `project` (default `"eit"`): This is the project name for which KMS will be created.
* `policy` (default `"null"`): Policy applied to the key.
* `alias` (default `"dynamodb_kms"`): This is the alias name of KMS key. This must be unique in the account, eg: bucketkey,EBSKey,DynamoDBKey,Myownkey.
* `tags_override` (default ``): A custom map of tags to override default tags.

## Output Values
* `arn`
* `id`

## Managed Resources
* `aws_kms_key.key` from `aws`

## Child Modules
* `common` from `../common`
* `tags` from `../aws-tags`

