resource "aws_cloudwatch_log_group" "main" {
  name              = var.log_group_name
  retention_in_days = var.retention_in_days
  kms_key_id        = var.kms_key_id
  tags              = var.tags
}

resource "aws_cloudwatch_log_metric_filter" "main" {
  count          = var.create_metric_filter ? 1 : 0
  name           = var.metric_filter_name
  log_group_name = aws_cloudwatch_log_group.main.name
  pattern        = var.metric_filter_pattern

  metric_transformation {
    name          = var.metric_name
    namespace     = var.metric_namespace
    value         = var.metric_value
    default_value = var.metric_default_value
    unit          = var.metric_unit
  }
}

resource "aws_cloudwatch_metric_alarm" "main" {
  count               = var.create_alarm && var.create_metric_filter ? 1 : 0
  alarm_name          = var.alarm_name
  alarm_description   = var.alarm_description
  comparison_operator = var.alarm_comparison_operator
  evaluation_periods  = var.alarm_evaluation_periods
  threshold           = var.alarm_threshold
  metric_name         = var.create_metric_filter ? aws_cloudwatch_log_metric_filter.main[0].metric_transformation[0].name : var.metric_name
  namespace           = var.create_metric_filter ? aws_cloudwatch_log_metric_filter.main[0].metric_transformation[0].namespace : var.metric_namespace
  period              = var.alarm_metric_period
  statistic           = var.alarm_statistic
  treat_missing_data  = var.alarm_treat_missing_data
  alarm_actions       = var.alarm_actions
  ok_actions          = var.ok_actions
  insufficient_data_actions = var.insufficient_data_actions
}
