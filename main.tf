resource "aws_db_instance" "postgres_instance" {
  allocated_storage    = 20
  engine               = "postgres"
  engine_version       = "17"
  identifier           = "projetofiap"
  db_name = "projetofiap"
  instance_class       = "db.t3.micro"
  username             = "postgres_user"
  password             = "mypassword"
  skip_final_snapshot  = true
  vpc_security_group_ids = ["sg-04bafac48988566d9"]
  publicly_accessible = true
}
