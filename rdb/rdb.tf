resource "aws_db_instance" "mydb" {
  allocated_storage      = 10
  engine                 = "postgres"
  engine_version         = "13"
  instance_class         = "db.${var.instance_type}"
  db_name                = var.resoursename
  username               = var.username
  password               = var.password
  parameter_group_name   = "default.postgres13"
  db_subnet_group_name   = var.subnet-group-id
  vpc_security_group_ids = [var.rds_sg]
  skip_final_snapshot    = true
}
