locals {
  region-map = {
    eu-west-1 = "DUB"
    eu-west-2 = "LON"
  }
  region_shortname         = local.region-map[data.aws_region.current.name]
  permissions_boundary_arn = var.landscape == "LZ" ? "arn:aws:iam::${data.aws_caller_identity.current.account_id}:policy/lz-glo-iam-pb-lz" : "arn:aws:iam::${data.aws_caller_identity.current.account_id}:policy/AWS_${local.region_shortname}_POL_StandardRolePermissionsBoundary_protected"
  ssm_logging_policy_arn   = var.landscape == "LZ" ? "" : "arn:aws:iam::${data.aws_caller_identity.current.account_id}:policy/AWS_EDFE_CENTRALS3KMSDECRYPT_POL_CMPPolicyEnforcement_protected"
  ec2_role_lz              = var.policy_document == false ? "lz-glo-iam-rol-ssm_protected" : join("", aws_iam_instance_profile.ec2_ins_prof.*.name)
  ec2_role_ma              = var.policy_document == false ? "AWS_${local.region_shortname}_ROL_SSM_protected" : join("", aws_iam_instance_profile.ec2_ins_prof.*.name)
  instance_profile         = var.landscape == "LZ" ? local.ec2_role_lz : local.ec2_role_ma
  ec2_role_custom          = var.landscape == "LZ" ? "lz-glo-iam-rol-ssm_${var.project}" : "AWS_${local.region_shortname}_ROL_SSM_${var.project}"
  ec2_role_name            = var.ec2_role_name == null ? local.ec2_role_custom : var.ec2_role_name
  policy_name              = var.policy_name == null ? "policy-${var.project}-${var.environment}-${var.service}" : var.policy_name
  role_default             = var.landscape == "LZ" ? "lz-glo-iam-rol-ssm_protected" : "AWS_${local.region_shortname}_ROL_SSM_protected"

  managed_policies = compact([
    "arn:aws:iam::aws:policy/service-role/AmazonEC2RoleforSSM",
    "arn:aws:iam::aws:policy/service-role/AWSLambdaBasicExecutionRole",
    local.ssm_logging_policy_arn
  ])
}
