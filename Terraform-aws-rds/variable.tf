variable "region" {
  description = "The AWS region to create resources in"
  type        = string
  default     = "us-east-1"
}

variable "aurora_admin_password" {
  description = "The password for the Aurora cluster admin user"
  type        = string
}
