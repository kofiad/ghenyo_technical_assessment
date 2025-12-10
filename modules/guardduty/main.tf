resource "aws_guardduty_detector" "main" {
  enable                        = var.enable
  finding_publishing_frequency  = var.finding_publishing_frequency
  tags                          = var.tags

  datasources {
    s3_logs {
      enable = var.enable_s3_logs
    }
  }
}

resource "aws_guardduty_member" "main" {
  for_each = {
    for member in var.members : member.account_id => member
  }

  detector_id                   = aws_guardduty_detector.main.id
  account_id                    = each.value.account_id
  email                         = each.value.email
  disable_email_notification    = !var.notify_members
  invite                        = var.invite_members
  depends_on                    = [aws_guardduty_detector.main]
}
