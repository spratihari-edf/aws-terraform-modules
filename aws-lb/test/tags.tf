module "tags" {
  source           = "git::ssh://git@github.com/edfenergy/eit-terraform-modules.git//aws-tags"
  name             = "project-test"
  business_unit    = "Customers"
  major_function   = "eit"
  cost_centre      = "5100"
  // edfe_environment = "SandPit"
  // environment      = "SandPit"
  // project          = "test-proj"
  // service          = "test-serv"
  // work_order       = "test-wo"
  // service_level    = "Bronze"
  // creator          = "test-module"
} 