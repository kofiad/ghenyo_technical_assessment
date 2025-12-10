data "aws_region" "current" {}

data "aws_iam_policy_document" "assume_role" {
  statement {
    effect = "Allow"
    actions = ["sts:AssumeRole"]
    principals {
      type        = "Service"
      identifiers = ["config.amazonaws.com"]
    }
  }
}

data "aws_iam_policy_document" "delivery_policy" {
  statement {
    effect    = "Allow"
    actions   = ["s3:GetBucketLocation", "s3:PutObject"]
    resources = [
      "arn:aws:s3:::${var.s3_bucket_name}",
      "arn:aws:s3:::${var.s3_bucket_name}/*",
    ]
  }

  dynamic "statement" {
    for_each = var.kms_key_id != null ? [var.kms_key_id] : []
    content {
      effect    = "Allow"
      actions   = [
        "kms:Encrypt",
        "kms:Decrypt",
        "kms:GenerateDataKey",
        "kms:ReEncrypt*",
        "kms:DescribeKey",
      ]
      resources = [statement.value]
      condition {
        test     = "Bool"
        variable = "kms:ViaService"
        values   = ["s3.${data.aws_region.current.name}.amazonaws.com"]
      }
    }
  }
}

resource "aws_iam_role" "config_recorder" {
  name               = var.role_name
  assume_role_policy = data.aws_iam_policy_document.assume_role.json
  tags               = var.tags
}

resource "aws_iam_role_policy" "delivery" {
  name   = "config-delivery-policy"
  role   = aws_iam_role.config_recorder.id
  policy = data.aws_iam_policy_document.delivery_policy.json
}

resource "aws_config_configuration_recorder" "main" {
  name     = var.recorder_name
  role_arn = aws_iam_role.config_recorder.arn

  recording_group {
    all_supported                = var.record_all_supported
    include_global_resource_types = var.include_global_resource_types
  }
}

resource "aws_config_delivery_channel" "main" {
  name           = var.delivery_channel_name
  s3_bucket_name = var.s3_bucket_name
  s3_key_prefix  = var.s3_key_prefix
  sns_topic_arn  = var.sns_topic_arn
  depends_on     = [aws_config_configuration_recorder.main]
}