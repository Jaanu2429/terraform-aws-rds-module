provider "aws" {
  region = var.region
}

# Retrieve the default VPC in the specified region
data "aws_vpc" "default" {
  default = true
}

# Retrieve the default subnets in the default VPC
data "aws_subnets" "default" {
  filter {
    name   = "vpc-id"
    values = [data.aws_vpc.default.id]
  }
}

# Use the existing default subnets
resource "aws_security_group" "aurora_sg" {
  vpc_id = data.aws_vpc.default.id

  ingress {
    from_port   = 5432
    to_port     = 5432
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]  # Adjust this as needed for security
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "aurora-sg"
  }
}

resource "aws_rds_cluster" "aurora_cluster" {
  cluster_identifier      = "aurora-cluster-demo-us-east-1"
  engine                  = "aurora-postgresql"
  engine_version          = "11.9"
  master_username         = "auroraadmin"
  master_password         = var.aurora_admin_password
  db_subnet_group_name    = aws_db_subnet_group.aurora.id
  vpc_security_group_ids  = [aws_security_group.aurora_sg.id]
  skip_final_snapshot     = true

  tags = {
    Name = "aurora-cluster"
  }
}

resource "aws_rds_cluster_instance" "aurora_instance" {
  count              = 2
  identifier         = "aurora-instance-us-east-1-${count.index}"
  cluster_identifier = aws_rds_cluster.aurora_cluster.id
  instance_class     = "db.r5.large"
  engine             = aws_rds_cluster.aurora_cluster.engine
  engine_version     = aws_rds_cluster.aurora_cluster.engine_version
  publicly_accessible = true

  tags = {
    Name = "aurora-instance-${count.index}"
  }
}

resource "aws_db_subnet_group" "aurora" {
  name       = "aurora-subnet-group-us-east-1"
  subnet_ids = data.aws_subnets.default.ids

  tags = {
    Name = "aurora-subnet-group-us-east-1"
  }
}
