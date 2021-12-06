output "ec2_instance" {
  value       = aws_instance.ec2instance
  description = "This is ec2 instance object"
}

output "instance_profile_name" {
  value       = local.instance_profile
  description = "Instance profile name for future use"
}
