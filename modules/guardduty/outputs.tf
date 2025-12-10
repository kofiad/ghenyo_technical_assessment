output "detector_id" {
  description = "GuardDuty detector identifier"
  value       = aws_guardduty_detector.main.id
}

output "detector_arn" {
  description = "ARN of the GuardDuty detector"
  value       = aws_guardduty_detector.main.arn
}

output "member_accounts" {
  description = "Map of invited member account IDs to email addresses"
  value = {
    for id, member in aws_guardduty_member.main : id => member.email
  }
}
