
#DataBase Subnet Group

resource "aws_db_subnet_group" "rds_vpc_dev_sg" {
  name       = "rds_vpc_dev_sg"
  subnet_ids = ["${var.sn_vpc_dev_priv_2a_id}", "${var.sn_vpc_dev_priv_2b_id}"]

  tags = {
    "Name" = "rds_vpc_dev_sg"
  }
}

#DB Parameter Group
resource "aws_db_parameter_group" "rds_vpc_dev_parameter_group" {
  name   = "rds-vpc-dev-parameter-group"
  family = "${var.family}"

  parameter {
    name  = "character_set_server"
    value = "${var.charset}"
  }

  parameter {
    name  = "character_set_client"
    value = "${var.charset}"
  }
}

#instância rds
resource "aws_db_instance" "rds_db_challenge" {
  identifier              = "rds-db-challenge"
  multi_az                = "${var.multi_az}"
  engine                  = "${var.engine}"
  engine_version          = "${var.engine_version}"
  instance_class          = "${var.instance_class}"
  storage_type            = "${var.storage_type}"
  allocated_storage       = "${var.allocated_storage}"
  max_allocated_storage   = 0
  monitoring_interval     = 0
  name                    = "${var.rds_name}"
  username                = "${var.rds_user}"
  password                = "${var.rds_password}"
  skip_final_snapshot     = true
  db_subnet_group_name    = aws_db_subnet_group.rds_vpc_dev_sg.name
  parameter_group_name    = aws_db_parameter_group.rds_vpc_dev_parameter_group.name
  vpc_security_group_ids  = ["${var.vpc_dev_security_group_priv_id}"]

  tags = {
    "Name" = "rds-db-challenge"
  }
}
