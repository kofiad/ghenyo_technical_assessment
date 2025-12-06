output "s3_bucket_name" {
  description = "Name of the provisioned S3 bucket"
  value       = aws_s3_bucket.main.bucket
}

output "s3_bucket_id" {
  description = "ID for the bucket"
  value       = aws_s3_bucket.main.id
}

output "s3_bucket_arn" {
  description = "ARN of the bucket"
  value       = aws_s3_bucket.main.arn
}

output "kms_key_id" {
  description = "ID of the KMS key securing the bucket"
  value       = data.aws_kms_key.default.id
}

output "kms_key_arn" {
  description = "ARN of the bucket's KMS key"
  value       = data.aws_kms_key.default.arn
}