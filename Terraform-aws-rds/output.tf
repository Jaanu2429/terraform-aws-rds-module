output "aurora_cluster_endpoint" {
  value = aws_rds_cluster.aurora_cluster.endpoint
}

output "aurora_cluster_reader_endpoint" {
  value = aws_rds_cluster.aurora_cluster.reader_endpoint
}
