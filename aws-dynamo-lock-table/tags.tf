module "tags" {
  source      = "../aws-tags"
  name        = "${var.project}-${var.environment}-${var.name}"
  environment = var.environment
  tags        = var.tags_override
}