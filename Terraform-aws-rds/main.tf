provider "aws" {
  region = var.region
}

module "vpc" {
  source            = "./modules/vpc"
  cidr_block        = var.vpc_cidr_block
  subnet_count      = var.subnet_count
  subnet_cidr_blocks = var.subnet_cidr_blocks
  instance_tenancy  = var.instance_tenancy
  tags              = var.vpc_tags
}

module "security_group" {
  source = "./modules/security_group"
  vpc_id = module.vpc.vpc_id
}

module "rds" {
  source                = "./modules/rds"
  vpc_id                = module.vpc.vpc_id
  subnet_ids            = module.vpc.subnet_ids
  security_group_id     = module.security_group.security_group_id
  instance_count        = var.instance_count
  instance_type         = var.instance_type
  db_admin_password     = var.db_admin_password
  allocated_storage     = var.allocated_storage
  db_name               = var.db_name
  engine                = var.engine
  engine_version        = var.engine_version
}
