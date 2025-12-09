include "root" {
  path = find_in_parent_folders()
}

dependency "vpc" {
  config_path = "../vpc"
}

dependency "log_bucket" {
  config_path = "../../../global/s3"
}

locals {
  certificate_arn = get_env("ALB_CERTIFICATE_ARN", "")
  target_group_arn = get_env("ALB_TARGET_GROUP_ARN", "")
}

terraform {
  source = "../../../../modules/alb"
}

inputs = {
  alb_name            = "dev-backend-alb"
  subnet_ids          = [dependency.vpc.outputs.public_subnet_a_id]
  environment         = "dev"
  log_bucket_id       = dependency.log_bucket.outputs.s3_bucket_id
  certificate_arn     = local.certificate_arn
  target_group_arn    = local.target_group_arn
}
