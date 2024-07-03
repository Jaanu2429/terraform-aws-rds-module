variable "region" {
  description = "The AWS region to create resources in"
  type        = string
  default     = "us-east-1"
}

variable "vpc_cidr_block" {
  description = "The CIDR block for the VPC"
  type        = string
  default     = "10.0.0.0/16"
}

variable "subnet_count" {
  description = "Number of subnets to create in the VPC"
  type        = number
  default     = 2
}

variable "subnet_cidr_blocks" {
  description = "List of CIDR blocks for the subnets"
  type        = list(string)
  default     = ["10.0.1.0/24", "10.0.2.0/24"]
}

variable "instance_tenancy" {
  description = "The supported tenancy options for instances launched into the VPC"
  type        = string
  default     = "default"
}

variable "vpc_tags" {
  description = "A map of tags to assign to the VPC"
  type        = map(string)
  default     = {
    Name = "main-vpc"
  }
}

variable "instance_count" {
  description = "Number of RDS instances"
  type        = number
  default     = 2
}

variable "instance_type" {
  description = "The instance type for the RDS instances"
  type        = string
  default     = "db.r5.large"
}

variable "db_admin_password" {
  description = "The password for the RDS admin user"
  type        = string
}

variable "allocated_storage" {
  description = "The amount of allocated storage (in GB) for the RDS instances"
  type        = number
  default     = 100
}

variable "db_name" {
  description = "The name of the database"
  type        = string
  default     = "mydatabase"
}

variable "engine" {
  description = "The database engine for the RDS instances (mysql, postgres, aurora)"
  type        = string
  default     = "aurora"
}

variable "engine_version" {
  description = "The version of the database engine"
  type        = string
  default     = "11.9"
}
