# Terragrunt config for backend bootstrap using the reusable module
terraform {
  source = "../../../modules/backend-bootstrap"
}

# Disable remote state for bootstrap (chicken-and-egg issue)
remote_state {
  backend = "local"
  
  config = {}
  
  generate = {
    path      = "backend.tf"
    if_exists = "overwrite"
  }
}

inputs = {
  aws_region           = "eu-west-2"
  state_bucket_prefix  = "terraform-state"
  lock_table_name      = "terraform-locks"
  environment          = "bootstrap"
}
