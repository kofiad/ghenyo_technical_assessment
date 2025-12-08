data "aws_region" "current" {}

data "aws_caller_identity" "current" {}

resource "aws_kms_key_policy" "default" {
  key_id = var.kms_key_id
  policy = data.aws_iam_policy_document.default.json
}

data "aws_iam_policy_document" "default" {
  statement {
    sid = "AllowRootAccess"
    actions = ["kms:*"]
    effect = "Allow"
    principals {
      type = "AWS"
      identifiers = ["arn:aws:iam::${data.aws_caller_identity.current.account_id}:root"]
    }
    resources = ["*"]
  }

  statement {
    sid = "AllowInstanceRolesByTag"
    actions = ["kms:Decrypt", "kms:Encrypt", "kms:GenerateDataKey"]
    effect = "Allow"
    principals {
      type = "AWS"
      identifiers = ["*"]
    }
    resources = [aws_kms_key.default.arn]

    condition {
      test = "StringEquals"
      variable = "aws:RequestTag/Environment"
      values = [var.environment]
    }

    condition {
      test = "StringEquals"
      variable = "aws:RequestTag/Domain"
      values = [var.environment]
    }

    condition {
      test = "StringEquals"
      variable = "aws:RequestTag/Workload"
      values = [var.environment]
    }
  }
}