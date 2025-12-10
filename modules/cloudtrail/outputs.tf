output "trail_id" {
  description = "ID of the created CloudTrail"
  value       = aws_cloudtrail.main.id
}

output "trail_arn" {
  description = "ARN of the CloudTrail"
  value       = aws_cloudtrail.main.arn
}

output "trail_name" {
  description = "Name of the CloudTrail"
  value       = aws_cloudtrail.main.name
}
