module "tags_loadbalancer" {
  source      = "../aws-tags"
  name        = var.override_lb_name == null ? local.lbname : var.override_lb_name
  tags        = var.tags_override
}

module "tags_target_group" {
  source      = "../aws-tags"
  name        = var.override_tg_name == null ? local.tgname : var.override_tg_name
  tags        = var.tags_override
}