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
  publicly_accessible = true
  vpc_security_group_ids = ["sg-08acb5901abef9267"]

}
