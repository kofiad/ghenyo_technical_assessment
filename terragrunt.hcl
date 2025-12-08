# Root Terragrunt configuration to wire all modules to the bootstrapped remote state

locals {
  aws_region        = get_env("AWS_REGION", "eu-west-2")
  state_bucket_name = "terraform-state-${get_aws_account_id()}-${local.aws_region}"
  lock_table_name   = "terraform-locks"
}

remote_state {
  backend = "s3"

  config = {
    bucket         = local.state_bucket_name
    key            = "${path_relative_to_include()}/terraform.tfstate"
    region         = local.aws_region
    encrypt        = true
    dynamodb_table = local.lock_table_name
  }

  generate = {
    path      = "backend.tf"
    if_exists = "overwrite_terragrunt"
  }
}

generate "provider" {
  path      = "provider.tf"
  if_exists = "overwrite_terragrunt"

  contents = <<-EOF
    terraform {
      required_version = ">= 1.3"
      required_providers {
        aws = {
          source  = "hashicorp/aws"
          version = "~> 5.0"
        }
      }
    }

    provider "aws" {
      region = "${local.aws_region}"
    }
  EOF
}
