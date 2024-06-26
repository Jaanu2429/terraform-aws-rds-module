variable "region" {
  description = "The AWS region to create resources in"
  type        = string
  default     = "us-west-2"
}

variable "aurora_admin_password" {
  description = "The password for the Aurora cluster admin user"
  type        = string
}
