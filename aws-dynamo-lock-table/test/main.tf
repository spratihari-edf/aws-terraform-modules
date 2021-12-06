provider "aws" {
  region = "eu-west-1"
}
module "dynamo-db-no-kms" {
  source = "../"
  name   = "dynamodb-with-new-kms"
}
