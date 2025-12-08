locals {
  aws_region = get_env("AWS_REGION", "eu-west-2")
}

inputs = {
  aws_region = local.aws_region
}
