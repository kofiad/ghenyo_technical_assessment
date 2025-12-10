include "root" {
  path = find_in_parent_folders()
}

dependency "vpc" {
  config_path = "../../networking/vpc"
}

dependency "alb" {
  config_path = "../../networking/alb"
}

dependency "rds" {
  config_path = "../database/rds"
}

locals {
  container_image = get_env("BACKEND_CONTAINER_IMAGE", "public.ecr.aws/nginx/nginx:latest")
}

terraform {
  source = "../../../../modules/ecs"
}

inputs = {
  env_name           = "dev"
  container_image    = local.container_image
  vpc_id             = dependency.vpc.outputs.vpc_id
  private_subnet_ids = [dependency.vpc.outputs.private_subnet_a_id]
  alb_sg_id          = dependency.alb.outputs.alb_security_group_id
  alb_listener_arn   = dependency.alb.outputs.alb_https_listener_arn
  db_endpoint        = dependency.rds.outputs.db_endpoint
  db_port            = dependency.rds.outputs.db_port
  rds_sg_id          = dependency.rds.outputs.rds_security_group_id
}
