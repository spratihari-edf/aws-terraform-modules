resource "aws_security_group" "asg_security_group" {
  count       = length(var.security_group_id) > 0 ? 0 : 1
  name_prefix = local.security_group_name_prefix
  description = "allow all vpc traffic to ec2."
  vpc_id      = var.vpc_id
  ingress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = [data.aws_vpc.selected.cidr_block]
  }
  tags = merge(module.tags.tags,
    {
      "Name" = trimsuffix(local.security_group_name_prefix, "-")
  })
}