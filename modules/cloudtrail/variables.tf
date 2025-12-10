variable "trail_name" {
  description = "Friendly name for the CloudTrail trail"
  type        = string
}

variable "s3_bucket_name" {
  description = "S3 bucket that receives the CloudTrail logs"
  type        = string
}

variable "s3_key_prefix" {
  description = "Optional prefix inside the bucket"
  type        = string
  default     = ""
}

variable "include_global_service_events" {
  description = "Whether to capture global AWS events"
  type        = bool
  default     = true
}

variable "is_multi_region_trail" {
  description = "Capture events across all AWS regions"
  type        = bool
  default     = true
}

variable "enable_log_file_validation" {
  description = "Enable log file integrity checks"
  type        = bool
  default     = true
}

variable "is_organization_trail" {
  description = "Enable the trail for the organization (requires AWS Organizations)"
  type        = bool
  default     = false
}

variable "enable_logging" {
  description = "Start the trail immediately"
  type        = bool
  default     = true
}

variable "kms_key_id" {
  description = "KMS key used to encrypt log files (optional)"
  type        = string
  default     = null
}

variable "cloud_watch_logs_role_arn" {
  description = "IAM role ARN that CloudTrail uses to push events to CloudWatch logs"
  type        = string
  default     = null
}

variable "cloud_watch_logs_group_arn" {
  description = "ARN of the CloudWatch log group to stream CloudTrail events into"
  type        = string
  default     = null
}

variable "tags" {
  description = "Tags to apply to the CloudTrail resources"
  type        = map(string)
  default     = {}
}
