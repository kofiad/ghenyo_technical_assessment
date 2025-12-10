variable "role_name" {
  description = "IAM role used by the AWS Config recorder"
  type        = string
  default     = "aws-config-recorder"
}

variable "recorder_name" {
  description = "Name of the AWS Config configuration recorder"
  type        = string
  default     = "config-recorder"
}

variable "delivery_channel_name" {
  description = "Name of the AWS Config delivery channel"
  type        = string
  default     = "config-delivery"
}

variable "s3_bucket_name" {
  description = "S3 bucket receiving CloudTrail snapshots"
  type        = string
}

variable "s3_key_prefix" {
  description = "Key prefix for configuration snapshots"
  type        = string
  default     = ""
}

variable "sns_topic_arn" {
  description = "SNS topic ARN used by the delivery channel (optional)"
  type        = string
  default     = null
}

variable "record_all_supported" {
  description = "Whether to record all supported resource types"
  type        = bool
  default     = true
}

variable "include_global_resource_types" {
  description = "Record global resource types (IAM, Route53, CloudFront, etc.)"
  type        = bool
  default     = true
}

variable "kms_key_id" {
  description = "Optional KMS key used to encrypt objects written to S3"
  type        = string
  default     = null
}

variable "tags" {
  description = "Tags applied to IAM role + recorder/delivery resources"
  type        = map(string)
  default     = {}
}
