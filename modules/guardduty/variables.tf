variable "enable" {
  description = "Enable the GuardDuty detector"
  type        = bool
  default     = true
}

variable "finding_publishing_frequency" {
  description = "How often GuardDuty publishes findings"
  type        = string
  default     = "SIX_HOURS"
}

variable "enable_s3_logs" {
  description = "Enable ingestion of S3 data source"
  type        = bool
  default     = false
}

variable "members" {
  description = "Additional AWS accounts to invite to GuardDuty"
  type = list(object({
    account_id = string
    email      = string
  }))
  default = []
}

variable "notify_members" {
  description = "Whether to send the initial email to invited members"
  type        = bool
  default     = true
}

variable "invite_members" {
  description = "Whether to automatically invite the provided member accounts"
  type        = bool
  default     = true
}

variable "tags" {
  description = "Tags to apply to GuardDuty resources"
  type        = map(string)
  default     = {}
}
