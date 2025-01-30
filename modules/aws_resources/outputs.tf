Below is the `outputs.tf` file that corresponds to the requirements and resources described in the Terraform script for AWS:

```hcl
output "s3_bucket_id" {
  description = "The ID of the S3 bucket used for storing AFT logs."
  value       = aws_s3_bucket.aft_logs.id
}

output "kms_key_arn" {
  description = "The ARN of the KMS key used for encryption."
  value       = aws_kms_key.aft_key.arn
}

output "sns_topic_arn" {
  description = "The ARN of the SNS topic used for AFT notifications."
  value       = aws_sns_topic.aft_notifications.arn
}

output "dynamodb_table_name" {
  description = "The name of the DynamoDB table used for handling AFT requests."
  value       = aws_dynamodb_table.aft_requests.name
}
```

### Explanation:
1. **S3 Bucket ID**: Outputs the ID of the S3 bucket created for storing AFT logs.
2. **KMS Key ARN**: Outputs the ARN of the KMS key used for encrypting resources.
3. **SNS Topic ARN**: Outputs the ARN of the SNS topic created for AFT notifications.
4. **DynamoDB Table Name**: Outputs the name of the DynamoDB table used for handling AFT requests.

These outputs can be used to reference the created resources in other modules or for documentation purposes.