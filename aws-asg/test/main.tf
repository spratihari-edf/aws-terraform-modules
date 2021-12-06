
provider "aws" {
  region = "eu-west-1"
}

locals {
  default_tags = {    
    "Business Unit" : var.business_unit,
    "Cost Centre" : var.cost_centre,
    "Project Environment" : var.environment,
    "Environment" : var.edfe_environment,
    "Project" : var.project,
    "Service" : var.service,
    "Work Order" : var.work_order,
    "Major Function" : var.major_function,
    "Service Level" : var.service_level,
    "Creator" : var.creator
  }
}

module "asg_example_1" {
  source               = "../"
  landscape            = "MA"
  launch_config_name   = "test"
  asg_name             = "test"
  instance_type        = "t3.large"
  key_name             = "keyname"
  ec2_ami_id           = "ami-111111"
  iam_instance_profile = "arn:aws:iam::111111:instance-profile/profilename"
  ebs_optimized        = false
  user_data            = "test"
  desired_capacity     = 2
  max_size             = 3
  min_size             = 2
  health_check_type    = "EC2"
  vpc_id               = "vpc-741d5b12"
  ebs_block_device = [
    {
      device_name           = "/dev/xvdz"
      volume_type           = "gp2"
      volume_size           = "50"
      delete_on_termination = true
    },
  ]

  root_block_device = [
    {
      volume_size           = "50"
      volume_type           = "gp2"
      delete_on_termination = true
    },
  ]

  create_before_destroy = "false"

  tags_override = local.default_tags

}


module "asg_example_withlifecyclehook" {
  source               = "../"
  landscape            = "MA"
  instance_type        = "t3.large"
  key_name             = "keyname"
  ec2_ami_id           = "ami-111111"
  iam_instance_profile = "arn:aws:iam::111111:instance-profile/profilename"
  ebs_optimized        = false
  user_data            = "test"
  desired_capacity     = 2
  max_size             = 3
  min_size             = 2
  health_check_type    = "EC2"
  vpc_id               = "vpc-741d5b12"
  ebs_block_device = [
    {
      device_name           = "/dev/xvdz"
      volume_type           = "gp2"
      volume_size           = "50"
      delete_on_termination = true
    },
  ]

  root_block_device = [
    {
      volume_size           = "50"
      volume_type           = "gp2"
      delete_on_termination = true
    },
  ]

  initial_lifecycle_hook_details = [
    {
      initial_lifecycle_hook_name                 = "my-hook"
      initial_lifecycle_hook_lifecycle_transition = "autoscaling:EC2_INSTANCE_LAUNCHING"
    }
  ]
  tags_override = local.default_tags

}
