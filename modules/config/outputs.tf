output "config_role_arn" {
  description = "ARN of the IAM role assumed by AWS Config"
  value       = aws_iam_role.config_recorder.arn
}

output "recorder_name" {
  description = "Name of the configuration recorder"
  value       = aws_config_configuration_recorder.main.name
}

output "delivery_channel_arn" {
  description = "ARN of the delivery channel"
  value       = aws_config_delivery_channel.main.arn
}
