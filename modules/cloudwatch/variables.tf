variable "log_group_name" {
  description = "Name of the CloudWatch log group"
  type        = string
}

variable "retention_in_days" {
  description = "Retention period for log data"
  type        = number
  default     = 30
}

variable "kms_key_id" {
  description = "Optional KMS key ARN or ID for log encryption"
  type        = string
  default     = null
}

variable "tags" {
  description = "Tags to apply to resources"
  type        = map(string)
  default     = {}
}

variable "create_metric_filter" {
  description = "Enable creation of a metric filter"
  type        = bool
  default     = true
}

variable "metric_filter_name" {
  description = "Name for the CloudWatch metric filter"
  type        = string
  default     = "error-filter"
}

variable "metric_filter_pattern" {
  description = "Match pattern that drives the metric"
  type        = string
  default     = "ERROR"
}

variable "metric_name" {
  description = "Name of the metric emitted by the filter"
  type        = string
  default     = "ApplicationErrors"
}

variable "metric_namespace" {
  description = "CloudWatch namespace for the metric"
  type        = string
  default     = "Application/Metrics"
}

variable "metric_value" {
  description = "Value emitted when the filter matches"
  type        = string
  default     = "1"
}

variable "metric_default_value" {
  description = "Default value when no metric data is sent"
  type        = number
  default     = 0
}

variable "metric_unit" {
  description = "Unit for the emitted metric"
  type        = string
  default     = "Count"
}

variable "create_alarm" {
  description = "Enable an alarm tied to the metric filter"
  type        = bool
  default     = false
}

variable "alarm_name" {
  description = "Name of the CloudWatch alarm"
  type        = string
  default     = "metric-filter-alarm"
}

variable "alarm_description" {
  description = "Description for the alarm"
  type        = string
  default     = "Metric filter alarm"
}

variable "alarm_comparison_operator" {
  description = "Comparison operator for the alarm"
  type        = string
  default     = "GreaterThanOrEqualToThreshold"
}

variable "alarm_evaluation_periods" {
  description = "Number of periods the metric must breach threshold"
  type        = number
  default     = 1
}

variable "alarm_threshold" {
  description = "Threshold that triggers the alarm"
  type        = number
  default     = 1
}

variable "alarm_metric_period" {
  description = "Evaluation period in seconds"
  type        = number
  default     = 60
}

variable "alarm_statistic" {
  description = "Statistic used for the alarm"
  type        = string
  default     = "Sum"
}

variable "alarm_treat_missing_data" {
  description = "How to treat missing metric data"
  type        = string
  default     = "missing"
}

variable "alarm_actions" {
  description = "ARNs of actions to execute when alarm fires"
  type        = list(string)
  default     = []
}

variable "ok_actions" {
  description = "ARNs of actions when alarm data is OK"
  type        = list(string)
  default     = []
}

variable "insufficient_data_actions" {
  description = "ARNs of actions when data is insufficient"
  type        = list(string)
  default     = []
}
