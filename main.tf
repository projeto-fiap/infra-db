resource "aws_db_instance" "postgres_instance" {
  allocated_storage    = 20
  engine               = "postgres"
  engine_version       = "17"
  identifier           = "projetofiap1"
  db_name = "projetofiap"
  instance_class       = "db.t3.micro"
  username             = "postgres_user"
  password             = "mypassword"
  skip_final_snapshot  = true
  publicly_accessible = true
  vpc_security_group_ids = ["sg-00d2805cd528877e3"]

}
