include "root" {
	path = find_in_parent_folders()
}

terraform {
  source = "../../../../modules/rds"
}

dependency "vpc" {
	config_path = "../../networking/vpc"
}

dependency "kms" {
	config_path = "../../kms/kms_cmk"
}

inputs = {
	name = "ghenyo-ta-backend"
	db_name = "backend"
	db_engine = "postgres"
	db_username = "postgres"
	vpc_id = dependency.vpc.outputs.vpc_id
	database_port = 5432
	allowed_cidr_block = ["10.0.0.64/26", "10.0.0.128/26"]
	max_allocated_storage = 15
	kms_key_id = dependency.kms.outputs.kms_key_arn
	private_subnet_ids = ["10.0.0.64/26", "10.0.0.128/26"]
}
