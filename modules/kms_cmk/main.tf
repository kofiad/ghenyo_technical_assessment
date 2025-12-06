resource "aws_kms_key" "default" {
  description             = var.description
  deletion_window_in_days = var.deletion_window_in_days
  enable_key_rotation = var.enable_key_rotation
}

resource "aws_kms_alias" "default" {
  name          = "alias/${var.alias_name}"
  target_key_id = aws_kms_key.default.key_id
}