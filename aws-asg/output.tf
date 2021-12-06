output "auto_scaling_group" {
  description = "object with all attributes for autoscaling group."
  value = var.create_before_destroy == "true" ? aws_autoscaling_group.asg_group : aws_autoscaling_group.asg_group_fl
}

output "launch_configuration" {
  description = "object with all attributes for launch configuration."
  value = var.create_before_destroy == "true" ? aws_launch_configuration.launch_config : aws_launch_configuration.launch_config_fl
}
