include "root" {
  path = find_in_parent_folders()
}

dependency "frontend_s3" {
  config_path = "../s3"
}

terraform {
  source = "../../../../modules/cloudfront"
}

inputs = {
  name = "frontend-oac"
  description = "frontend s3 origin access control"
  origin_access_control_origin_type = "s3"
  bucket_regional_domain_name = dependency.frontend_s3.outputs.s3_bucket_regional_domain_name
  bucket_id                    = dependency.frontend_s3.outputs.s3_bucket_id
}
