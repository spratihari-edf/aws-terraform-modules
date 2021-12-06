provider "aws" {
  region = "eu-west-1"
}

# #################################################################
# ## ec2 instance provisioning using DEFAULT Instance profile
# ## lz-glo-iam-rol-ssm_protected in LZ or
# ## AWS_DUB_ROL_SSM_protected / AWS_LON_ROL_SSM_protected in MA
# #################################################################

module "ec2_instance_linux_without_usrdata_iampolicy" {
  source                  = "../"
  landscape               = "LZ"
  ami_id                  = "ami-014ce76919b528bff"
  ec2_instance_size       = "t2.micro"
  ec2_key_name            = "eit-lz-prov-jb"
  subnetid                = "subnet-06ab0534ff55e88dd"
  security_group_id       = ["sg-0b8700617c10fe1f6"]
  kms_key_arn             = "arn:aws:kms:eu-west-1:476766377179:key/9021b7e5-9e7a-47a5-9ef1-ffa715647bad"
  disable_api_termination = true
  environment             = "Secondary"
  edfe_environment        = "PreProduction"
  patching_enabled        = "true"
  patch_group             = "Secondary-PreProd"
  project                 = "test"
  service                 = "test"
  name                    = "test-ssm-patching-ec2"
  ebs_optimized           = false
  root_volume_size        = "100"
  root_volume_type        = "gp2"
  root_volume_iops        = null
  root_volume_throughput  = null
  ebs_volume = [
    {
      size        = 100,
      type        = "gp2",
      device_name = "/dev/sdb"
    },
    {
      size        = 100,
      type        = "gp3",
      device_name = "/dev/sdc"
      iops        = 3000
      throughput  = 125
      snapshot_id = "snap-mysnapshot1"
    }
  ]
  cost_centre    = "TABB"
  major_function = "EIT Terraform Modules"
  business_unit  = "Customers"
  work_order     = "TABB"
  creator        = "Terraform"
  service_level  = "Platinum"
}


###########################################################################
## ec2 instance provisioning using CUSTOMIZED Instance profile in LZ and MA
###########################################################################

# Example for Linux ##

module "ec2_instance_linux" {
  source                 = "../"
  landscape              = "LZ"
  ami_id                 = "ami-0bb3fad3c0286ebd5"
  ec2_instance_size      = "t2.micro"
  ec2_key_name           = "test"
  subnetid               = "subnet-099b9bd849f8ebbd5"
  security_group_id      = ["sg-02fcc59b533c36517"]
  kms_key_arn            = "arn:aws:kms:eu-west-1:025863501615:key/baef2e08-4666-4d36-b56d-838065bc5c07"
  ebs_optimized          = false
  root_volume_size       = "100"
  root_volume_type       = "gp3"
  root_volume_iops       = 3000
  root_volume_throughput = 125
  ebs_block_device = [
    {
      size                  = 200,
      type                  = "gp2",
      device_name           = "/dev/sdb"
      delete_on_termination = true
    },
    {
      size                  = 100,
      type                  = "gp3",
      device_name           = "/dev/sdc"
      iops                  = 3000
      throughput            = 125
      delete_on_termination = true
    }

  ]
  environment      = "test"
  project          = "test"
  edfe_environment = "PreProduction"
  patching_enabled = "true"
  patch_group      = "Secondary-PreProd"
  service          = "test"
  name             = "test"
  user_data        = file("shell.sh")
  ec2_role_name    = "lz-glo-iam-rol-custom"
  policy_name      = "lz-glo-iam-pol-custom"
  policy_document  = data.aws_iam_policy_document.ec2_policy.json
  cost_centre      = "TABB"
  major_function   = "EIT Terraform Modules"
  business_unit    = "Customers"
  work_order       = "TABB"
  creator          = "Terraform"
  service_level    = "Platinum"
}

module "ec2_instance_linux_no_key_pair" {
  source            = "../"
  landscape         = "LZ"
  ami_id            = "ami-0bb3fad3c0286ebd5"
  ec2_instance_size = "t2.micro"
  subnetid          = "subnet-099b9bd849f8ebbd5"
  security_group_id = ["sg-02fcc59b533c36517"]
  kms_key_arn       = "arn:aws:kms:eu-west-1:025863501615:key/baef2e08-4666-4d36-b56d-838065bc5c07"
  ebs_optimized     = false
  environment       = "test"
  project           = "test"
  edfe_environment  = "PreProduction"
  patching_enabled  = "true"
  patch_group       = "Secondary-PreProd"
  service           = "test"
  name              = "test"
  user_data         = file("shell.sh")
  ec2_role_name     = "lz-glo-iam-rol-custom"
  policy_name       = "lz-glo-iam-pol-custom"
  policy_document   = data.aws_iam_policy_document.ec2_policy.json
  cost_centre       = "TABB"
  major_function    = "EIT Terraform Modules"
  business_unit     = "Customers"
  work_order        = "TABB"
  creator           = "Terraform"
  service_level     = "Platinum"
}

data "aws_iam_policy_document" "ec2_policy" {
  statement {
    effect = "Allow"
    actions = [
      "ec2:*"
    ]
    resources = ["*"]
  }
}

# ## Example for Windows ##

module "ec2_instance_windows" {
  source            = "../"
  landscape         = "LZ"
  ami_id            = "ami-03acdf9028d28249e"
  ec2_instance_size = "t2.micro"
  ec2_key_name      = "test"
  subnetid          = "subnet-099b9bd849f8ebbd5"
  security_group_id = ["sg-02fcc59b533c36517"]
  kms_key_arn       = "arn:aws:kms:eu-west-1:025863501615:key/baef2e08-4666-4d36-b56d-838065bc5c07"
  environment       = "test"
  project           = "test"
  edfe_environment  = "PreProduction"
  patching_enabled  = "true"
  patch_group       = "Secondary-PreProd"
  service           = "test"
  name              = "test"
  policy_document   = data.aws_iam_policy_document.ec2_policy.json
  user_data         = file("powershell.ps1")
  cost_centre       = "TABB"
  major_function    = "EIT Terraform Modules"
  business_unit     = "Customers"
  work_order        = "TABB"
  creator           = "Terraform"
  service_level     = "Platinum"
}
