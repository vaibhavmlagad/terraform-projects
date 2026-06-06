# AWS Remote State Terraform Project

This directory contains Terraform configuration for managing remote state bootstrap resources and environment infrastructure in two separate stages.

## Overview

- `bootstrap/` creates the AWS remote state backend resources:
  - S3 bucket for Terraform state storage
  - DynamoDB table for state locking
- `environments/` contains environment-specific infrastructure and references the remote state backend configuration

## Directory layout

- `bootstrap/main.tf` - bootstrap Terraform config for backend resources
- `bootstrap/outputs.tf` - outputs for the created S3 bucket and DynamoDB table
- `environments/conf/backend-dev.conf` - backend configuration for the dev environment
- `environments/dev/main.tf` - dev environment Terraform configuration
- `environments/dev/variables.tf` - variables used by the dev environment

## Bootstrap instructions

The bootstrap module creates the S3 bucket and DynamoDB table used by environment state backends.

### Important details

- If `bootstrap/main.tf` declares `provider "aws" {}` with no explicit `region`.
- The AWS region for bootstrap is resolved by the AWS SDK lookup order:
  1. `AWS_REGION` environment variable
  2. `AWS_DEFAULT_REGION` environment variable
  3. AWS CLI profile configuration (`~/.aws/config` or `~/.aws/credentials`)
  4. EC2/ECS metadata or other default AWS SDK sources
- If no region is found, Terraform will fail.

### Apply bootstrap

```powershell
cd terraform-projects/aws/remote_state/bootstrap
terraform init
terraform apply
```

After apply, the following resources are available:
- S3 bucket for Terraform state storage
- DynamoDB table for Terraform state locking

## Dev environment instructions

The dev environment uses remote state backend configuration from `environments/conf/backend-dev.conf`.

### Backend configuration

`environments/conf/backend-dev.conf` contains:

- `bucket = "<account_id>-terraform-states"`
- `key = "dev/service-name.tfstate"`
- `region = "ap-south-1"`
- `dynamodb_table = "terraform-lock"`
- `encrypt = true`

> Note: the `region` defined in the backend config is for the S3 backend itself, not for the AWS provider used by resources.

- `use_lockfile = true`

> Note: HashiCorp has deprecated DynamoDB-based state locking in favor of native S3 locking using: `use_lockfile = true`. Terraform's official documentation states that DynamoDB locking is deprecated and will be removed in a future release. Native S3 locking is now the recommended approach.

```powershell
╷
│ Warning: Deprecated Parameter
│ 
│   on main.tf line 3, in terraform:
│    3:     backend "s3" {
│ 
│ The parameter "dynamodb_table" is deprecated. Use parameter "use_lockfile" instead.
```



### Apply dev environment

```powershell
cd terraform-projects/aws/remote_state/environments/dev
terraform init -backend-config=../conf/backend-dev.conf
terraform plan
terraform apply
```

If you need to change the region or override defaults:

```powershell
terraform init -backend-config=../conf/backend-dev.conf -reconfigure
terraform apply -var="aws_region=ap-south-1"
```

# Destroy instructions

### Destroy dev environment

Run the destroy from the dev environment folder using the same backend config as apply:

```powershell
cd terraform-projects/aws/remote_state/environments/dev
terraform init -backend-config=../conf/backend-dev.conf
terraform destroy -var="aws_region=ap-south-1"
```

This destroys the resources managed in `environments/dev` and leaves the remote state backend intact.

### Destroy bootstrap backend

After the dev environment is destroyed and the state is no longer needed, destroy the bootstrap backend resources:

```powershell
cd terraform-projects/aws/remote_state/bootstrap
terraform init
terraform destroy
```

Destroying bootstrap will remove the S3 state bucket and the DynamoDB lock table. Only do this after all environment state has been cleaned up.

## Notes

- The `remote_state/bootstrap` workspace bootstraps the backend resources.
- The `remote_state/environments/dev` workspace uses that remote backend.
- `environments/conf/backend-qa.conf` exists for a QA-style backend config, but no `qa/` environment folder is present currently.
- Use separate environment folders and backend config files for additional environments.
