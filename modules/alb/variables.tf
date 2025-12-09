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

variable "certificate_arn" {
  description = "ARN of the SSL certificate for the HTTPS listener"
  type        = string
}

variable "target_group_arn" {
  description = "Optional target group ARN to forward HTTPS traffic to"
  type        = string
  default     = ""
}

locals {
  http_port    = 80
  https_port   = 443
  any_port     = 0
  tcp_protocol = "tcp"
  all_ips      = ["0.0.0.0/0"]
}