module "tags" {
  source           = "../aws-tags"
  name             = var.name
  environment      = var.environment
  edfe_environment = var.edfe_environment
  cost_centre      = var.cost_centre
  work_order       = var.work_order
  service_level    = var.service_level
  creator          = var.creator
  project          = var.project
  major_function   = var.major_function
  business_unit    = var.business_unit
  service          = var.service
  tags = merge(
    {
      "PatchingEnabled" : var.patching_enabled,
      "Patch Group" : var.patch_group,
      "Tenable" : var.tenable
    },
    var.tags_override
  )
}
