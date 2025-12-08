# Environment-level Terragrunt configuration inheriting root settings
include "root" {
  path = find_in_parent_folders()
}

# Override or pin the AWS region if desired
locals {
  aws_region = get_env("AWS_REGION", "eu-west-2")
}

inputs = {
  aws_region = local.aws_region
}
