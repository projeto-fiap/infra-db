provider "aws" {
  region = "us-east-1"
}

resource "aws_security_group" "db_sg" {
  name        = "db_sg"
  description = "Grupo de segurança para o banco de dados PostgreSQL"
  vpc_id      = "vpc-banco-postgres"

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

resource "aws_db_instance" "postgres_instance" {
  allocated_storage    = 20
  engine               = "postgres"
  engine_version       = "17"
  identifier = "projeto-fiap"
  instance_class       = "db.t3.micro"
  username             = "postgres_user"
  password             = "mypassword"
  skip_final_snapshot  = true

  vpc_security_group_ids = [aws_security_group.db_sg.id] # Associa o grupo de segurança
}
