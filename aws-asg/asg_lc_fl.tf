#######################
# Launch configuration
#######################
resource "aws_launch_configuration" "launch_config_fl" {
  count                       = var.create_before_destroy == "false" ? 1 : 0
  name                        = coalesce(var.launch_config_name, local.launch_config_name)
  image_id                    = var.ec2_ami_id
  instance_type               = var.instance_type
  iam_instance_profile        = var.iam_instance_profile
  key_name                    = var.key_name
  security_groups             = length(var.security_group_id) > 0 ? var.security_group_id : [aws_security_group.asg_security_group[0].id]
  associate_public_ip_address = false
  user_data                   = var.user_data
  user_data_base64            = var.user_data_base64
  enable_monitoring           = var.enable_monitoring
  placement_tenancy           = var.placement_tenancy
  ebs_optimized               = var.ebs_optimized

  dynamic "ebs_block_device" {
    for_each = var.ebs_block_device
    content {
      delete_on_termination = lookup(ebs_block_device.value, "delete_on_termination", null)
      device_name           = ebs_block_device.value.device_name
      encrypted             = lookup(ebs_block_device.value, "encrypted", null)
      iops                  = lookup(ebs_block_device.value, "iops", null)
      no_device             = lookup(ebs_block_device.value, "no_device", null)
      snapshot_id           = lookup(ebs_block_device.value, "snapshot_id", null)
      volume_size           = lookup(ebs_block_device.value, "volume_size", null)
      volume_type           = lookup(ebs_block_device.value, "volume_type", null)
    }
  }

  dynamic "ephemeral_block_device" {
    for_each = var.ephemeral_block_device
    content {
      device_name  = ephemeral_block_device.value.device_name
      virtual_name = ephemeral_block_device.value.virtual_name
    }
  }

  dynamic "root_block_device" {
    for_each = var.root_block_device
    content {
      delete_on_termination = lookup(root_block_device.value, "delete_on_termination", null)
      iops                  = lookup(root_block_device.value, "iops", null)
      volume_size           = lookup(root_block_device.value, "volume_size", null)
      volume_type           = lookup(root_block_device.value, "volume_type", null)
      encrypted             = lookup(root_block_device.value, "encrypted", null)
    }
  }
}

####################
# Autoscaling group
####################
resource "aws_autoscaling_group" "asg_group_fl" {
  count                = var.create_before_destroy == "false" ? 1 : 0
  name                 = coalesce(var.asg_name, local.asg_name)
  launch_configuration = aws_launch_configuration.launch_config_fl[count.index].name
  vpc_zone_identifier  = length(var.subnet_ids) > 0 ? var.subnet_ids : [for s in data.aws_subnet.vpc_subnet : s.id]
  max_size             = var.max_size
  min_size             = var.min_size
  desired_capacity     = var.desired_capacity

  load_balancers            = var.load_balancers
  health_check_grace_period = var.health_check_grace_period
  health_check_type         = var.health_check_type

  min_elb_capacity          = var.min_elb_capacity
  wait_for_elb_capacity     = var.wait_for_elb_capacity
  target_group_arns         = var.target_group_arns
  default_cooldown          = var.default_cooldown
  force_delete              = false
  termination_policies      = var.termination_policies
  suspended_processes       = var.suspended_processes
  placement_group           = var.placement_group
  enabled_metrics           = var.enabled_metrics
  metrics_granularity       = "1Minute"
  wait_for_capacity_timeout = "10m"
  protect_from_scale_in     = false
  service_linked_role_arn   = var.service_linked_role_arn
  max_instance_lifetime     = 0

  dynamic "tag" {
    for_each = local.asg_tags
    content {
      key                 = tag.value["key"]
      value               = tag.value["value"]
      propagate_at_launch = tag.value["propagate_at_launch"]
    }
  }

}

resource "aws_autoscaling_lifecycle_hook" "asg_lifecycle_fl" {
  for_each                = { for k in var.initial_lifecycle_hook_details : index(var.initial_lifecycle_hook_details, k) => k }
  name                    = contains(keys(each.value), "initial_lifecycle_hook_name") ? each.value.initial_lifecycle_hook_name : "asg-lifecycle-hook"
  autoscaling_group_name  = var.create_before_destroy == "false" ? aws_autoscaling_group.asg_group_fl[each.key].name : aws_autoscaling_group.asg_group[each.key].name
  default_result          = contains(keys(each.value), "initial_lifecycle_hook_default_result") ? each.value.initial_lifecycle_hook_default_result : "ABANDON"
  heartbeat_timeout       = contains(keys(each.value), "initial_lifecycle_hook_heartbeat_timeout") ? each.value.initial_lifecycle_hook_heartbeat_timeout : 60
  lifecycle_transition    = contains(keys(each.value), "initial_lifecycle_hook_lifecycle_transition") ? each.value.initial_lifecycle_hook_lifecycle_transition : ""
  notification_metadata   = contains(keys(each.value), "initial_lifecycle_hook_notification_metadata") ? each.value.initial_lifecycle_hook_notification_metadata : ""
  notification_target_arn = contains(keys(each.value), "initial_lifecycle_hook_notification_target_arn") ? each.value.initial_lifecycle_hook_notification_target_arn : ""
  role_arn                = contains(keys(each.value), "initial_lifecycle_hook_role_arn") ? each.value.initial_lifecycle_hook_role_arn : ""
}