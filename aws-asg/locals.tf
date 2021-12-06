locals {
  region-map = {
    eu-west-1 = "DUB"
    eu-west-2 = "LON"
  }

  region_shortname           = local.region-map[data.aws_region.current.name]
  launch_config_name         = var.landscape == "MA" ? "aws-${lower(local.region_shortname)}-lch-cfg" : "lz-${lower(local.region_shortname)}-lch-cfg"
  asg_name                   = var.landscape == "MA" ? "aws-${lower(local.region_shortname)}-asg-grp" : "lz-${lower(local.region_shortname)}-asg-grp"
  security_group_name_prefix = var.landscape == "MA" ? "aws-${lower(local.region_shortname)}-sec-grp-" : "lz-${lower(local.region_shortname)}-sec-grp-"
  asg_tags = { for k, v in merge(module.tags.tags, { "Name" = coalesce(var.asg_name, local.asg_name) }) : k => {
    "key"                 = k
    "value"               = v
    "propagate_at_launch" = true
    }
  }



}
