data "aws_region" "current" {}

data "aws_caller_identity" "current" {}

resource "aws_kms_key_policy" "default" {
  key_id = var.kms_key_id
  policy = data.aws_iam_policy_document.default.json
}

data "aws_iam_policy_document" "default" {
  # Allow root account full KMS access for key management
  statement {
    sid     = "EnableRootAccountPermissions"
    actions = ["kms:*"]
    effect  = "Allow"
    
    principals {
      type        = "AWS"
      identifiers = ["arn:aws:iam::${data.aws_caller_identity.current.account_id}:root"]
    }
    
    resources = ["*"]
  }

  # Allow CloudWatch Logs to use the key for encryption
  statement {
    sid = "AllowCloudWatchLogs"
    actions = [
      "kms:Encrypt",
      "kms:Decrypt",
      "kms:ReEncrypt*",
      "kms:GenerateDataKey*",
      "kms:CreateGrant",
      "kms:DescribeKey"
    ]
    effect = "Allow"
    
    principals {
      type        = "Service"
      identifiers = ["logs.${data.aws_region.current.name}.amazonaws.com"]
    }
    
    resources = ["*"]
    
    condition {
      test     = "ArnLike"
      variable = "kms:EncryptionContext:aws:logs:arn"
      values   = ["arn:aws:logs:${data.aws_region.current.name}:${data.aws_caller_identity.current.account_id}:*"]
    }
  }

  # Allow S3 to use the key for bucket encryption
  statement {
    sid = "AllowS3Service"
    actions = [
      "kms:Decrypt",
      "kms:GenerateDataKey"
    ]
    effect = "Allow"
    
    principals {
      type        = "Service"
      identifiers = ["s3.amazonaws.com"]
    }
    
    resources = ["*"]
  }

  # Allow ECS instances with specific tags to use the key
  statement {
    sid = "AllowInstanceRolesByTag"
    actions = [
      "kms:Decrypt",
      "kms:Encrypt",
      "kms:GenerateDataKey",
      "kms:DescribeKey"
    ]
    effect = "Allow"
    
    principals {
      type        = "AWS"
      identifiers = ["*"]
    }
    
    resources = ["*"]
    
    condition {
      test     = "StringEquals"
      variable = "aws:PrincipalTag/Environment"
      values   = [var.environment]
    }
  }

  # Allow RDS instances use the key for encryption
  statement {
    sid = "AllowRDSService"
    actions = [
      "kms:Encrypt",
      "kms:Decrypt",
      "kms:ReEncrypt*",
      "kms:GenerateDataKey*",
      "kms:CreateGrant",
      "kms:DescribeKey"
    ]
    effect = "Allow"

    principals {
      type        = "Service"
      identifiers = ["rds.amazonaws.com"]
    }

    resources = ["*"]
  }
}