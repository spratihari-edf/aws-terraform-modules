module "tags" {
  source = "../aws-tags"
  name   = { "Name" = coalesce(var.asg_name, local.asg_name) }
  tags   = var.tags_override
}
