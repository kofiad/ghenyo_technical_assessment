variable "vpc_cidr" {
  description = "cidr block for vpc"
  type = string
}

variable "vpc_name" {
  description = "name of vpc"
  type = string
}

variable "public_subnet_a_cidr" {
  description = "Number of IP addresses required for public subnet A"
  type        = string
}

variable "private_subnet_a_cidr" {
  description = "Number of IP addresses required for private subnet A"
  type        = string
}

variable "private_subnet_b_cidr" {
  description = "Number of IP addresses required for private subnet A"
  type        = string
}