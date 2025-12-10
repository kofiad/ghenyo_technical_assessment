resource "aws_db_subnet_group" "main" {
  name       = "${var.name}-db-sng"
  subnet_ids = var.private_subnet_ids

  tags = {
    Name = "${var.name}-db-sng"
  }
}

resource "aws_db_instance" "main" {
  identifier   = var.name
  engine              = var.db_engine
  engine_version = var.engine_version
  allocated_storage   = var.allocated_storage
  max_allocated_storage = var.max_allocated_storage
  instance_class      = var.db_instance_class
  storage_encrypted = true
  kms_key_id = var.kms_key_id
  publicly_accessible = false
  vpc_security_group_ids = [aws_security_group.rds_sg.id]
  db_subnet_group_name = aws_db_subnet_group.main.name
  db_name             = var.db_name
  username            = var.db_username
  password            = var.db_password
  skip_final_snapshot = true
}

resource "aws_security_group" "rds_sg" {
  name = "${var.name}-sg"
  description = "${var.name} rds instance security group"
  vpc_id = var.vpc_id

  ingress{
    description = "Allow database traffic on its port"
    from_port = var.database_port
    to_port = var.database_port
    protocol = "tcp"
    cidr_blocks = var.allowed_cidr_block #private subnet cidr
  }

  egress{
    from_port = 0
    to_port = 0
    protocol = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}