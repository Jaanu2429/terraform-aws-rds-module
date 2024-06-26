variable "region" {
  description = "The AWS region to create resources in"
  type        = string
}

variable "aurora_admin_password" {
  description = "The password for the Aurora cluster admin user"
  type        = string
}
