resource "aws_guardduty_detector" "main" {
  enable                        = var.enable
  finding_publishing_frequency  = var.finding_publishing_frequency
  tags                          = var.tags
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

resource "aws_guardduty_detector_feature" "s3_protection" {
  detector_id = aws_guardduty_detector.main.id
  name        = "S3_DATA_EVENTS"
  status      = "ENABLED"
}