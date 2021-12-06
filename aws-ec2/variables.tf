variable "name" {
  description = "EC2 name."
}

variable "ami_id" {
  type        = string
  description = "Amazone machine image id"
}

variable "ec2_instance_size" {
  type        = string
  description = "Ec2 instance t-shirt size"
}

variable "ec2_key_name" {
  type        = string
  description = "ec2 key pair name "
  default     = ""
}

variable "subnetid" {
  type        = string
  description = "subnet id in which instance will be created"
}

variable "security_group_id" {
  type        = list(string)
  description = "Security group id"
}

variable "kms_key_arn" {
  type        = string
  description = "Kms key using which EBS volume will be encrypted"
}

variable "user_data" {
  type        = string
  default     = ""
  description = "User data"
}

variable "environment" {
  type        = string
  description = "Environment secondary/primary"
}

variable "cost_centre" {
}

variable "major_function" {
}

variable "business_unit" {
}

variable "work_order" {
}

variable "creator" {
}

variable "service_level" {
}

variable "edfe_environment" {
  type        = string
  description = "EDFE Environment Production/Preproduction"
}

variable "patching_enabled" {
  type        = bool
  description = "Enable patching"
  default     = "true"
}

variable "patch_group" {
  type        = string
  description = "Name of the patch group which will patch the ec2 instance"
}

variable "project" {
  type        = string
  description = "Project name Ex. LZ"
}

variable "service" {
  type        = string
  description = "Service"
}

variable "tags_override" {
  type        = map(string)
  description = "A custom map of tags to override default tags"
  default     = {}
}

variable "private_ip" {
  type        = string
  default     = ""
  description = "static ip"
}

variable "landscape" {
  type        = string
  default     = "LZ"
  description = "In which landscape EC2 will be provisioned. MA/LZ"
}

variable "ebs_block_device" {
  type        = list(map(any))
  default     = []
  description = "List of EBS block devices"
}

variable "ebs_volume" {
  type        = list(map(any))
  default     = []
  description = "List of EBS volumes"
}

variable "root_volume_size" {
  type        = string
  default     = "50"
  description = "Optional: Root volume size in GB"
}

variable "root_volume_type" {
  type        = string
  default     = "gp3"
  description = "Optional: Root volume type"
}

variable "root_volume_iops" {
  type        = number
  default     = 3000
  description = "Root volume iops"
}

variable "root_volume_throughput" {
  type        = number
  default     = 125
  description = "Root volume throughput"
}

variable "ec2_role_name" {
  default     = null
  description = "Ec2 IAM Instance profile to create. Default is lz-glo-iam-rol-ssm_protected for LZ and AWS_DUB_ROL_SSM_protected / AWS_LON_ROL_SSM_protected for MA"
}

variable "policy_name" {
  default     = null
  description = "Ec2 IAM Instance profile policy name"
}

variable "policy_document" {
  default     = false
  description = "Ec2 IAM policy document to be attached to the Instance profile"
}


variable "tenable" {
  type        = string
  default     = "FA"
  description = "Tenable tag for EC2"
}

variable "disable_api_termination" {
  type        = bool
  default     = false
  description = "Should API termination be disabled"
}

variable "ebs_optimized" {
  type        = bool
  default     = false
  description = "Should the instance be EBS optimized"
}
