locals {  
  lbname = "${lower(var.projectname)}-loadbalancer"  
  tgname = "${lower(var.projectname)}-targetgroup"
}
