# Terragrunt config that provisions the frontend S3 bucket for CloudFront.
include "root" {
	path = find_in_parent_folders()
}

terraform {
	source = "../../../../modules/s3/frontend_s3"
}

locals {
	bucket_prefix = "ghenyo-frontend"
}

inputs = {
	bucket_name            = "${local.bucket_prefix}-${local.aws_region}"
	bucket_environment     = "dev"
	versioning_configuration = true
}

