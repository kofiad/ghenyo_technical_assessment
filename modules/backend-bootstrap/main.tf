terraform {
  required_version = ">= 1.3"
}

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

data "aws_caller_identity" "current" {}

locals {
  state_bucket_name = "${var.state_bucket_prefix}-${data.aws_caller_identity.current.account_id}-${var.aws_region}"
}

resource "aws_s3_bucket" "terraform_state" {
  bucket = local.state_bucket_name

  tags = {
    Name        = local.state_bucket_name
    Environment = var.environment
  }
}

resource "aws_s3_bucket_ownership_controls" "terraform_state" {
  bucket = aws_s3_bucket.terraform_state.id

  rule {
    object_ownership = "BucketOwnerEnforced"
  }
}

resource "aws_s3_bucket_versioning" "terraform_state" {
  bucket = aws_s3_bucket.terraform_state.id

  versioning_configuration {
    status = "Enabled"
  }
}

resource "aws_s3_bucket_server_side_encryption_configuration" "terraform_state" {
  bucket = aws_s3_bucket.terraform_state.id

  rule {
    apply_server_side_encryption_by_default {
      sse_algorithm = "AES256"
    }
  }
}

resource "aws_s3_bucket_public_access_block" "terraform_state" {
  bucket = aws_s3_bucket.terraform_state.id

  block_public_acls       = true
  block_public_policy     = true
  ignore_public_acls      = true
  restrict_public_buckets = true
}

resource "aws_dynamodb_table" "terraform_locks" {
  name         = var.lock_table_name
  billing_mode = "PAY_PER_REQUEST"
  hash_key     = "LockID"

  attribute {
    name = "LockID"
    type = "S"
  }

  tags = {
    Name        = var.lock_table_name
    Environment = var.environment
  }
}

output "state_bucket_name" {
  description = "S3 bucket for Terraform state"
  value       = aws_s3_bucket.terraform_state.id
}

output "lock_table_name" {
  description = "DynamoDB table for state locking"
  value       = aws_dynamodb_table.terraform_locks.name
}
