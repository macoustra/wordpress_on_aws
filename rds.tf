resource "aws_db_subnet_group" "db_subnet" {
  name = "rdssubnetgroup"
  subnet_ids = [aws_subnet.andrew_private_subnet_1.id,aws_subnet.andrew_private_subnet_2.id]

  tags = {
    Name = "wordpress"
  }
}

resource "aws_rds_cluster" "auroracluster" {
  cluster_identifier        = "auroracluster"
  availability_zones        = ["eu-central-1a", "eu-central-1b"]

  engine                    = "aurora-mysql"
  engine_version            = "5.7.mysql_aurora.2.11.1"
  
  lifecycle {
    ignore_changes        = [engine_version]
  }

  database_name             = "auroradb"
  master_username           = "admin"
  master_password           = "wWkTAeM3n3ZQUlOBQzh0"

  skip_final_snapshot       = true
  final_snapshot_identifier = "aurora-final-snapshot"

  db_subnet_group_name = aws_db_subnet_group.db_subnet.name

  vpc_security_group_ids = [aws_security_group.allow_aurora_access.id]
  

  tags = {
    Name = "auroracluster-db"
  }
}

resource "aws_rds_cluster_instance" "clusterinstance" {
  count              = 2
  identifier         = "clusterinstance-${count.index}"
  cluster_identifier = aws_rds_cluster.auroracluster.id
  instance_class     = "db.t2.micro"
  engine             = "aurora-mysql"
  availability_zone  = "eu-central-1${count.index == 0 ? "a" : "b"}"
  publicly_accessible = true

  tags = {
    Name = "auroracluster-db-instance${count.index + 1}"
  }
}