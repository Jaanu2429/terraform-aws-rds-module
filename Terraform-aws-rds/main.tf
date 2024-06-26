provider "aws" {
  region = var.region
}

# Retrieve the default VPC
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

# Use the default subnets for the Aurora subnets
resource "aws_subnet" "aurora_subnet" {
  count             = 2
  vpc_id            = data.aws_vpc.default.id
  cidr_block        = cidrsubnet(data.aws_vpc.default.cidr_block, 8, count.index)
  availability_zone = element(data.aws_subnets.default.ids, count.index)

  tags = {
    Name = "aurora-subnet-${count.index}"
  }
}

resource "aws_security_group" "aurora_sg" {
  vpc_id = data.aws_vpc.default.id

  ingress {
    from_port   = 5432
    to_port     = 5432
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
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
  cluster_identifier      = "aurora-cluster-demo"
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
  identifier         = "aurora-instance-${count.index}"
  cluster_identifier = aws_rds_cluster.aurora_cluster.id
  instance_class     = "db.r5.large"
  engine             = aws_rds_cluster.aurora_cluster.engine
  engine_version     = aws_rds_cluster.aurora_cluster.engine_version

  tags = {
    Name = "aurora-instance-${count.index}"
  }
}

resource "aws_db_subnet_group" "aurora" {
  name       = "aurora-subnet-group-updated"
  subnet_ids = aws_subnet.aurora_subnet[*].id

  tags = {
    Name = "aurora-subnet-group-updated"
  }
}
