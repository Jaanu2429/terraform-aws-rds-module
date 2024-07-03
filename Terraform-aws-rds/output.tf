output "vpc_id" {
  value = module.vpc.vpc_id
}

output "subnet_ids" {
  value = module.vpc.subnet_ids
}

output "security_group_id" {
  value = module.security_group.security_group_id
}

output "rds_endpoint" {
  value = module.rds.endpoint
}

output "rds_reader_endpoint" {
  value = module.rds.reader_endpoint
}