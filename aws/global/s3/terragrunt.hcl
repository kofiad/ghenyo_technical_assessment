# Terragrunt config for backend bootstrap using the reusable module
terraform {
  source = "../../../modules/backend-bootstrap"
}

# Disable remote state for bootstrap (chicken-and-egg issue)
skip = false

inputs = {
  aws_region           = "eu-west-2"
  state_bucket_prefix  = "terraform-state"
  lock_table_name      = "terraform-locks"
  environment          = "bootstrap"
}
