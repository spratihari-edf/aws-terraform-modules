variable "environment" {
  description = "Used to distinguish between dev and prod infrastructure"
  default     = "Dev-Test"
}

variable "project" {
  description = "Used to identify the project"
  default     = "EIT Module"
}

variable "business_unit" {
  description = "EDFE :: Business Unit"
  default     = "Customers"
}

variable "cost_centre" {
  description = "EDFE :: Cost Centre"
  default     = "TABB"
}

variable "edfe_environment" {
  description = "EDFE :: Environment"
  default     = "Dev-Test"
}

variable "major_function" {
  description = "EDFE :: Major Function"
  default     = "EIT"
}

variable "service" {
  description = "EDFE :: Service (same as Project)"
  default     = "EIT"
}

variable "work_order" {
  description = "EDFE :: Work Order"
  default     = "NA"
}

variable "service_level" {
  description = "EDFE :: Service Level"
  default     = "Bronze"
}

variable "creator" {
  description = "EDFE :: Creator of the Resource"
  default     = "Terraform via CD Pipeline"
}
