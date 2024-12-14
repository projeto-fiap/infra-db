# Instância do banco de dados PostgreSQL
resource "aws_db_instance" "postgres_instance" {
  allocated_storage    = 20
  engine               = "postgres"
  engine_version       = "17"
  identifier           = "projeto-fiap"
  db_name = "projeto-fiap"
  instance_class       = "db.t3.micro"
  username             = "postgres_user"
  password             = "mypassword"
  skip_final_snapshot  = true
  vpc_security_group_ids = ["vpc-09dd19bba155232c5"]
}
