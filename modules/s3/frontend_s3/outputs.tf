output "s3_bucket_name" {
  description = "Name of the provisioned S3 bucket"
  value = aws_s3_bucket.main.bucket
}

output "s3_bucket_id" {
  description = "ID for the bucket"
  value = aws_s3_bucket.main.id
}

output "s3_bucket_arn" {
  description = "ARN of the bucket"
  value = aws_s3_bucket.main.arn
}

output "s3_bucket_regional_domain_name" {
  description = "Regional domain name for the bucket (used by CloudFront origins)"
  value       = format("%s.s3.%s.amazonaws.com", aws_s3_bucket.main.bucket, data.aws_region.current.name)
}