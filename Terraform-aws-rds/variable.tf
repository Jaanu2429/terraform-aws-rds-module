variable "region" {
  description = "The AWS region to create resources in"
  default     = "us-west-2"
}

variable "aurora_admin_password" {
  description = "The password for the Aurora cluster admin user"
  default     = "auroraadminpassword"
}
