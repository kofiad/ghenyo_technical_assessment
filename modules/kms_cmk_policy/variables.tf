variable "kms_key_id" {
  description = "ID of kms key"
  type        = string
}

variable "environment" {
  description = "Environment name for resource tagging and access control"
  type        = string
}