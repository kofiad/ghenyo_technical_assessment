variable "aws_region" {
  description = "AWS region"
  type        = string
}

variable "state_bucket_prefix" {
  description = "Prefix for state bucket name"
  type        = string
  default     = "terraform-state"
}

variable "lock_table_name" {
  description = "DynamoDB table for state locking"
  type        = string
  default     = "terraform-locks"
}

variable "environment" {
  description = "Environment tag"
  type        = string
  default     = "bootstrap"
}
