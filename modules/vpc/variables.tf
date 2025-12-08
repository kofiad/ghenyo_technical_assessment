variable "vpc_cidr" {
  description = "cidr block for vpc"
  type = string
}

variable "vpc_name" {
  description = "name of vpc"
  type = string
}

variable "public_subnet_a_ips" {
  description = "Number of IP addresses required for public subnet A"
  type        = number
  default     = 64
}

variable "public_subnet_b_ips" {
  description = "Number of IP addresses required for public subnet B"
  type        = number
  default     = 64
}

variable "private_subnet_a_ips" {
  description = "Number of IP addresses required for private subnet A"
  type        = number
  default     = 64
}

variable "private_subnet_b_ips" {
  description = "Number of IP addresses required for private subnet B"
  type        = number
  default     = 64
}

locals {
  # Extract VPC prefix length from CIDR
  vpc_prefix = tonumber(split("/", var.vpc_cidr)[1])
  
  # Calculate prefix length based on required IP addresses
  public_a_prefix = 32 - ceil(log(var.public_subnet_a_ips, 2))
  public_b_prefix = 32 - ceil(log(var.public_subnet_b_ips, 2))
  private_a_prefix = 32 - ceil(log(var.private_subnet_a_ips, 2))
  private_b_prefix = 32 - ceil(log(var.private_subnet_b_ips, 2))

  # Generate CIDR blocks (newbits = target_prefix - vpc_prefix)
  public_subnet_a_cidr = cidrsubnet(var.vpc_cidr, local.public_a_prefix - local.vpc_prefix, 0)
  public_subnet_b_cidr = cidrsubnet(var.vpc_cidr, local.public_b_prefix - local.vpc_prefix, 1)
  private_subnet_a_cidr = cidrsubnet(var.vpc_cidr, local.private_a_prefix - local.vpc_prefix, 2)
  private_subnet_b_cidr = cidrsubnet(var.vpc_cidr, local.private_b_prefix - local.vpc_prefix, 3)
}