variable "name" {
  description = "name of cloudfront origin access control"
  type = string
}

variable "description" {
  description = "describes the cloudfront origin access control"
  type = string
}

variable "origin_access_control_origin_type" {
  description = "type of origin access control"
  type = string
}

variable "signing_behavior" {
  description = "signing behaviour of origin access control"
  type = string
  default = "always"
}

variable "signing_protocol" {
  description = "signing protocol of origin access control"
  type = string
  default = "sigv4"
}

variable "bucket_regional_domain_name" {
  description = "Regional domain name of s3 bucket"
  type = string
}

variable "bucket_id" {
  description = "s3 bucket ID"
  type = string
}