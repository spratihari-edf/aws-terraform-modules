module "tags" {
  source      = "../aws-tags"
  name        = var.name
  environment = var.environment
  tags = merge({
    "Data Classification" : "PROTECT - PRIVATE",
    "Data Residency" : "EU",
    "Compliance" : var.compliance
    },
    var.tags_override
  )
}
