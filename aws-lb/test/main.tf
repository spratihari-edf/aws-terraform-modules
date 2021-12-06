provider "aws" {
  region = "eu-west-1"
}

#data "aws_caller_identity" "current" {}

# create an external ALB with default action to create a HTTP and HTTPS listener against a target group on HTTP
module "alb-default-actions" {
  source  = "../"  

  projectname = "testmodulealb"
  override_lb_name = "test-module-dev-lb"
  override_tg_name = "test-module-dev-tg"
  environment = "dev"
  load_balancer_type = "application"

  vpc_id             = "vpc-0dbb5abd413eed358"
  subnets            = ["subnet-0c79e3ba38708fbd1", "subnet-0f6421f907adcd846", "subnet-087a5242e2f068e6a"]
    
  access_logs = {
    bucket = "lz-dub-p47-s3-platform-logging-bucket"
  }

  target_groups = [
    { 
      override_tg_name = "test-module-dev-tg"
      backend_protocol = "HTTP"
      backend_port     = 80
      target_type      = "instance"
    }
  ]

  // https_listeners = [
  //   {
  //     port               = 443
  //     protocol           = "HTTPS"
  //     certificate_arn    = "arn:aws:acm:eu-west-1:774446151385:certificate/c4d1fc98-3b53-4d63-b0b2-89155802b999"
  //     target_group_index = 0
  //   }
  // ]

  http_tcp_listeners = [
    {
      port               = 80
      protocol           = "HTTP"
      target_group_index = 0
    }
  ]

}

output "alb_arn" {
  description = "The ALB ARN"
  value       = module.alb-default-actions.loadbalancer_arn
}

output "alb_target_group_arn" {
  description = "The ALB Target group ARN"
  value       = module.alb-default-actions.target_group_arns
}

# create an internal NLB with action TCP (8199) listener against a target group on TCP (8181)
module "nlb_internal" {
  source  = "../"
  projectname = "testmodulenlb"
  environment = "dev"
  load_balancer_type = "network"

  vpc_id             = "vpc-0dbb5abd413eed358"
  subnets            = ["subnet-0c79e3ba38708fbd1", "subnet-0f6421f907adcd846", "subnet-087a5242e2f068e6a"]
    
  access_logs = {
    bucket = "lz-dub-p47-s3-platform-logging-bucket"
  }

  target_groups = [
    {      
      backend_protocol = "TCP"
      backend_port     = 8181
      target_type      = "ip"
    }
  ]
  
  http_tcp_listeners = [
    {
      port               = 8199
      protocol           = "TCP"
      target_group_index = 0
    }
  ]
  tags_override    = module.tags.tags
}

output "internal_nlb_arn" {
  description = "The NLB ARN"
  value       = module.nlb_internal.loadbalancer_arn
}

output "internal_nlb_target_group_arn" {
  description = "The NLB Target group ARN"
  value       = module.nlb_internal.target_group_arns
}
