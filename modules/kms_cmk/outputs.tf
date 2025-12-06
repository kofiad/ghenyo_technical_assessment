output "kms_key_id" {
  value = aws_kms_key.default.id
  description = "ID of kms key"
}

output "kms_key_arn" {
  value = aws_kms_key.default.arn
  description = "ARN of kms key"
}

output "kms_alias_name" {
  value = aws_kms_alias.default.name
  description = "Alias name for kms key"
}