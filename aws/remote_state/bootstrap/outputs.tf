output "s3_bucket_name" {
  value = aws_s3_bucket.terraform_state.id
  description = "The NAME of the s3 bucket used for Terraform state storage."
}

output "s3_bucket_arn" {
  value = aws_s3_bucket.terraform_state.arn
  description = "The ARN of the s3 bucket used for Terraform state storage."
}

output "s3_bucket_region" {
  value = aws_s3_bucket.terraform_state.region
  description = "The AWS region where the s3 bucket used for Terraform state storage is located."
}

output "dynamodb_table_name" {
  value = aws_dynamodb_table.terraform_lock.name
  description = "The NAME of the DynamoDB table used for Terraform state locking."
}

output "dynamodb_table_arn" {
  value = aws_dynamodb_table.terraform_lock.arn
  description = "The ARN of the DynamoDB table used for Terraform state locking."
}

output "dynamodb_table_region" {
  value = aws_dynamodb_table.terraform_lock.region
  description = "The AWS region where the DynamoDB table used for Terraform state locking is located."
}