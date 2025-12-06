variable "bucket_name" {
  description = "name of s3 bucket"
  type = string
  default = ""
}

variable "bucket_environment" {
  description = "environment of bucket"
  type = string
}

variable "versioning_configuration" {
  description = "checks to enable versioning on s3 bucket"
  type = bool
  default = true
}