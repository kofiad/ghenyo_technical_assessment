variable "description" {
  description = "KMS key description"
  type = string
  default = ""
}

variable "deletion_window_in_days" {
  description = "Number of days before deleting a cmk"
  type = number
  default = 30
}

variable "alias_name" {
  description = "KMS key alias name"
  type = string
}

variable "enable_key_rotation" {
  description = "Enables kms key rotation"
  type = bool
  default = true
}