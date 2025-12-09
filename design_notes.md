# Design Notes

## Security
- **Identity**: Enforce least privilege for service-to-service communication using IAM roles (e.g., IAM roles for ECS tasks, Lambda, and services) and tightly scoped IAM user access for humans.
- **Encryption**: Terminate TLS/SSL on CloudFront and the ALB for data in transit; enable SSE on S3 and use a customer-managed KMS key for RDS storage encryption so data is encrypted at rest.
- **Networking**: Use Security Groups as virtual firewalls. ALB allows HTTP/HTTPS from the internet, the ECS backend SG accepts traffic only from the ALB SG, and the RDS SG only accepts the database port from the ECS SG.

## Scalability
- **Frontend**: CloudFront caches content globally, while S3 provides virtually limitless storage and throughput for static assets.
- **Backend**: ECS on Fargate can scale horizontally with automatic scaling policies (e.g., target tracking on CPU/request count); the ALB load balances across all healthy tasks.
- **Database**: RDS can autoscale storage and add read replicas in private subnets to offload read-heavy workloads.

## Cost Optimization
- **Concrete Measure**: Commit to AWS Compute Savings Plans or RDS Reserved Instances for predictable workloads (1/3 year) since the database may most likely be the largest ongoing cost.

## Security & Operations
### PII Protections
- **At Rest**: Encrypt RDS volumes with KMS and application-level masking/tokenization for sensitive fields(jwt tokens).
- **In Transit**: Enforce TLS/HTTPS for all external and internal traffic; the ALB should reject unencrypted requests.
- **In Use**: Store secrets in AWS Secrets Manager and grant read-only access to ECS task roles instead of hardcoding credentials.

### Audit Logging
- **Infrastructure/API calls**: Enable CloudTrail globally to track API calls and store immutable logs in S3.
- **Configuration Changes**: Use AWS Config to record resource configuration changes (e.g., Security Group updates) for compliance.

### Misconfiguration Prevention
- **Open SG Ports**: Apply least privilege; the RDS SG only permits the ECS backend SG on the database port.
- **Public S3 Bucket**: Configure CloudFront Origin Access Control, deny public bucket access, and only allow the OAC to read the bucket.

### Incident Response
1. **Containment**: Reduce the ECS desired count to zero or roll back to a known-good image; rotate/revoke compromised credentials.
2. **Investigation**: Analyze CloudTrail and VPC Flow Logs; snapshot the RDS instance for forensics.
3. **Recovery**: Redeploy via Terraform after cleaning the infrastructure, then scale ECS back to normal capacity.