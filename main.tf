provider "aws" {
  region = "us-east-1"
}

resource "aws_vpc" "main_vpc" {
  cidr_block = "10.0.0.0/16"
  tags = {
    Name = "main_vpc"
  }
}

resource "aws_subnet" "main_subnet_1" {
  vpc_id            = aws_vpc.main_vpc.id
  cidr_block        = "10.0.1.0/24"
  availability_zone = "us-east-1a"
  tags = {
    Name = "main_subnet_1"
  }
}

resource "aws_subnet" "main_subnet_2" {
  vpc_id            = aws_vpc.main_vpc.id
  cidr_block        = "10.0.2.0/24"
  availability_zone = "us-east-1b"
  tags = {
    Name = "main_subnet_2"
  }
}

resource "aws_security_group" "db_sg" {
  name        = "db_sg"
  description = "grupo de seguranca para o banco de dados postgresql"
  vpc_id      = aws_vpc.main_vpc.id

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
    Name = "db_sg"
  }
}

# Instância do banco de dados PostgreSQL
resource "aws_db_instance" "postgres_instance" {
  allocated_storage    = 20
  engine               = "postgres"
  engine_version       = "17"
  identifier           = "projeto-fiap"
  instance_class       = "db.t3.micro"
  username             = "postgres_user"
  password             = "mypassword"
  skip_final_snapshot  = true
  vpc_security_group_ids = [aws_security_group.db_sg.id]
  db_subnet_group_name = aws_db_subnet_group.main_subnet_group.name
}

# Grupo de Sub-rede do Banco de Dados
resource "aws_db_subnet_group" "main_subnet_group" {
  name       = "main_subnet_group"
  subnet_ids = [
    aws_subnet.main_subnet_1.id,
    aws_subnet.main_subnet_2.id
  ]

  tags = {
    Name = "main_subnet_group"
  }
}
