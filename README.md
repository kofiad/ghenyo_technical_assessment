## Overview
- **Cloud provider:** AWS (familiarity-based preference)
- **Region:** `eu-west-2` (chosen for lowest latency from my location, ~127ms)
- **Purpose:** Terraform/Terragrunt configuration for provisioning infrastructure with remote state locking and modular components.

## Prerequisites
1. AWS account with programmatic access (access key ID + secret access key).
2. Installed and configured **AWS CLI** (ensure credentials/profile is set).
3. **Terragrunt** (handles module orchestration).
4. **Terraform** or **OpenTofu** (depending on your preference) to satisfy Terragrunt's backend requirements.

## Deployment Steps
1. Navigate to `aws/global/s3` and run the following commands in order:
	```bash
	terragrunt init
	terragrunt plan
	terragrunt apply
	```
	This bootstraps the remote state backend (S3) used across stacks.
2. From the repository root, initialise Terragrunt to lock remote state:
	```bash
	terragrunt init
	terragrunt apply
	```
3. To provision further resources, change directory to the desired stack under `aws/dev` (e.g., `aws/dev/networking/vpc`) and rerun:
	```bash
	terragrunt init
	terragrunt plan
	terragrunt apply
	```
	Repeat this pattern for each module you wish to deploy.

## Destroying Resources
- To clean up a specific environment or module, switch to that directory and run:
  ```bash
  terragrunt destroy
  ```
- Destroying stacks in reverse dependency order (e.g., app resources before shared infrastructure) helps avoid dependency conflicts.

## Notes
- Remote state is managed through the S3 backend configured in `aws/global/s3`.
- Always run `terragrunt init` before planning or applying to ensure backend and provider plugins are ready.