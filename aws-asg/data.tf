data "aws_caller_identity" "current" {}

data "aws_region" "current" {}

data "aws_vpc" "selected" {
  id = var.vpc_id
}
data "aws_subnet_ids" "vpc_subnets" {
  vpc_id = var.vpc_id
}
data "aws_subnet" "vpc_subnet" {
  for_each = data.aws_subnet_ids.vpc_subnets.ids
  id       = each.value
}
