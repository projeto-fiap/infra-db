data "aws_vpc" "vpc" {
  cidr_block =  "172.31.0.0/16"
}

resource "aws_security_group" "db_security_group" {
  name        = "SG-FIAP-BD"
  description = "Allow database access"
  vpc_id      = data.aws_vpc.vpc.id

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
}

resource "aws_db_instance" "postgres_instance_tech_challenge" {
  allocated_storage    = 20
  engine               = "postgres"
  engine_version       = "17"
  identifier           = "projetofiap"
  db_name              = "projetofiap"
  instance_class       = "db.t3.micro"
  username             = "postgres"
  password             = "postgres"
  skip_final_snapshot  = true
  publicly_accessible  = true
  vpc_security_group_ids = [aws_security_group.db_security_group.id]
}

resource "aws_db_instance" "postgres_instance_tech_challenge_payments" {
  allocated_storage    = 20
  engine               = "postgres"
  engine_version       = "17"
  identifier           = "projetofiappayments"
  db_name              = "projetofiap"
  instance_class       = "db.t3.micro"
  username             = "postgres"
  password             = "postgres"
  skip_final_snapshot  = true
  publicly_accessible  = true
  vpc_security_group_ids = [aws_security_group.db_security_group.id]
}

resource "aws_security_group" "docdb_security_group" {
  name        = "docdb-security-group"
  description = "Allow traffic for DocumentDB"
  vpc_id      = data.aws_vpc.vpc.id

  ingress {
    from_port   = 27017
    to_port     = 27017
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"] # Ajuste conforme a necessidade de restrição de IPs
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

# Cluster DocumentDB
resource "aws_docdb_cluster" "documentdb_cluster" {
  cluster_identifier      = "documentdb-cluster"
  master_username         = "adminuser"
  master_password         = "admin12345"
  backup_retention_period = 7
  preferred_backup_window = "07:00-09:00"
  engine_version          = "4.0.0"
  skip_final_snapshot  = true
  vpc_security_group_ids  = [aws_security_group.docdb_security_group.id]

  storage_encrypted = true

}
