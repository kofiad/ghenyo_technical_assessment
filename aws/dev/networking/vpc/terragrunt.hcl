# Terragrunt configuration for VPC in dev environment
include "root" {
  path = find_in_parent_folders()
}

terraform {
  source = "../../../../modules/vpc"
}

inputs = {
  vpc_cidr  = "10.0.0.0/24"
  vpc_name  = "dev-main-vpc"
  
  # Subnet IP counts (will auto-calculate CIDR blocks)
  public_subnet_a_ips  = 64
  public_subnet_b_ips  = 64
  private_subnet_a_ips = 64
  private_subnet_b_ips = 64
}
