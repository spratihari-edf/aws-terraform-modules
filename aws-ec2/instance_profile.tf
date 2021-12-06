resource "aws_iam_role" "ec2_role" {
  count                = var.policy_document == false ? 0 : 1
  name                 = local.ec2_role_name
  assume_role_policy   = data.aws_iam_policy_document.assume_role_policy.json
  permissions_boundary = local.permissions_boundary_arn
  tags                 = module.tags.tags
}

data "aws_iam_policy_document" "assume_role_policy" {
  statement {
    actions = [
      "sts:AssumeRole",
    ]
    principals {
      type        = "Service"
      identifiers = ["ec2.amazonaws.com"]
    }
  }
}

resource "aws_iam_policy" "ec2_policy" {
  count       = var.policy_document == false ? 0 : 1
  name        = local.policy_name
  path        = "/"
  description = "Policy for ${var.project} ${var.environment} ${var.service}"
  policy      = var.policy_document
  tags        = module.tags.tags
}

resource "aws_iam_role_policy_attachment" "inline" {
  count      = var.policy_document == false ? 0 : 1
  role       = aws_iam_role.ec2_role[count.index].name
  policy_arn = aws_iam_policy.ec2_policy[count.index].arn
}

resource "aws_iam_role_policy_attachment" "managed" {
  count      = var.policy_document == false ? 0 : 1
  role       = aws_iam_role.ec2_role[count.index].name
  policy_arn = element(local.managed_policies, count.index)
}

resource "aws_iam_instance_profile" "ec2_ins_prof" {
  count = var.policy_document == false ? 0 : 1
  role  = aws_iam_role.ec2_role[count.index].name
  name  = aws_iam_role.ec2_role[count.index].name
  tags  = module.tags.tags
}
