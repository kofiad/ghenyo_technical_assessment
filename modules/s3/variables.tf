variable "bucket_name" {
  description = "name of s3 bucket"
  type        = string
  default     = ""
}

variable "bucket_environment" {
  description = "environment of bucket"
  type        = string
}

variable "versioning_configuration" {
  description = "checks to enable versioning on s3 bucket"
  type        = bool
  default     = true
}

variable "kms_key_alias" {
  description = "The alias of the existing KMS key to use for S3 bucket encryption (e.g., 'alias/aws/s3' or 'alias/my-s3-key')"
  type        = string
  default     = "alias/aws/s3"
}