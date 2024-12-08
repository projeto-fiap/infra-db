provider "aws" {
  region = "us-east-1"
}

resource "aws_db_instance" "postgres_instance" {
  allocated_storage    = 20
  engine               = "postgres"
  engine_version       = "17"
  identifier = "my-postgres-instance"
  instance_class       = "db.t3.micro"
  username             = "postgres_user"
  password             = "mypassword"
  skip_final_snapshot  = true
}
