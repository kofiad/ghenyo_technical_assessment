output "log_group_name" {
  description = "Name of the created CloudWatch log group"
  value       = aws_cloudwatch_log_group.main.name
}

output "metric_filter_name" {
  description = "Name of the metric filter (if created)"
  value       = aws_cloudwatch_log_metric_filter.main[*].name
}

output "metric_alarm_arns" {
  description = "ARNs for the created alarms (if any)"
  value       = aws_cloudwatch_metric_alarm.main[*].arn
}
