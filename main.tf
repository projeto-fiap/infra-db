provider "aws" {
  region = "us-east-1" # Specify your desired region
}

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

resource "aws_db_instance" "postgres_instance_ms_kitchen" {
  allocated_storage    = 20
  engine               = "postgres"
  engine_version       = "17"
  identifier           = "mskitchendb"
  db_name              = "mskitchendb"
  instance_class       = "db.t3.micro"
  username             = "postgres"
  password             = "postgres"
  skip_final_snapshot  = true
  publicly_accessible  = true
  vpc_security_group_ids = [aws_security_group.db_security_group.id]
}

resource "aws_db_instance" "postgres_instance_tech_challenge_order" {
  allocated_storage    = 20
  engine               = "postgres"
  engine_version       = "17"
  identifier           = "projetofiaporder"
  db_name              = "orderdb"
  instance_class       = "db.t3.micro"
  username             = "postgres"
  password             = "postgres"
  skip_final_snapshot  = true
  publicly_accessible  = true
  vpc_security_group_ids = [aws_security_group.db_security_group.id]
}

