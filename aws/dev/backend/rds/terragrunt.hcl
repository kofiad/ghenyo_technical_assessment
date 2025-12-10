include "root" {
	path = find_in_parent_folders()
}

dependency "vpc" {
	config_path = "../../networking/vpc"
}

dependency "kms" {
	config_path = "../../kms/kms_cmk"
}

locals {
  db_username = get_env("RDS_DB_USERNAME", "backend_user")
  db_password = get_env("RDS_DB_PASSWORD", "")
}

terraform {
  source = "../../../../modules/rds"
}

inputs = {
  name                  = "ghenyo-ta-backend"
  db_instance_class     = "db.t3.micro"
  db_engine             = "postgres"
  db_username           = local.db_username
  db_password           = local.db_password
  private_subnet_ids    = [dependency.vpc.outputs.private_subnet_a_id]
  vpc_id                = dependency.vpc.outputs.vpc_id
  database_port         = 5432
  multi_az              = false
  allocated_storage     = 10
  allowed_cidr_block    = [dependency.vpc.outputs.private_subnet_a_cidr]
  max_allocated_storage = 15
  kms_key_id            = dependency.kms.outputs.kms_key_arn
  db_name               = "backendDev"
  private_subnet_a_ids  = [
    dependency.vpc.outputs.private_subnet_a_id,
    dependency.vpc.outputs.private_subnet_b_id,
  ]
}