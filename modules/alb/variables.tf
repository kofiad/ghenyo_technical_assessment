# ---------------------------------------------------------------------------------------------------------------------
# REQUIRED PARAMETERS
# You must provide a value for each of these parameters.
# ---------------------------------------------------------------------------------------------------------------------

variable "alb_name" {
  description = "The name to use for this ALB"
  type        = string
}

variable "subnet_ids" {
  description = "The subnet IDs to deploy to"
  type        = list(string)
}

variable "environment" {
  description = "environment for deployment"
  type = string
}

variable "log_bucket_id" {
  description = "s3 bucket for lb logs"
  type = string
}

variable "vpc_id" {
  description = "ID of the vpc"
  type = string
}

locals {
  http_port    = 80
  https_port   = 443
  any_port     = 0
  tcp_protocol = "tcp"
  all_ips      = ["0.0.0.0/0"]
}