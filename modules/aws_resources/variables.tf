Below is the `variables.tf` file based on the details provided in your questions and answers:

```hcl
variable "s3_bucket_name" {
  description = "The name of the S3 bucket for storing AFT logs."
  type        = string
}

variable "master_account_id" {
  description = "The AWS account ID of the master account."
  type        = string
}

variable "environment" {
  description = "The environment for the resources (e.g., Production, Development)."
  type        = string
  default     = "Production"
}

variable "kms_key_alias" {
  description = "The alias for the KMS key used for encryption."
  type        = string
  default     = "alias/aft-key"
}

variable "sns_topic_name" {
  description = "The name of the SNS topic for AFT notifications."
  type        = string
  default     = "aft-notifications"
}

variable "dynamodb_table_name" {
  description = "The name of the DynamoDB table for handling AFT requests."
  type        = string
  default     = "aft-requests"
}

variable "cloudwatch_log_group_name" {
  description = "The name of the CloudWatch Log Group for AFT logs."
  type        = string
  default     = "aft-log-group"
}

variable "cloudwatch_log_retention_days" {
  description = "The retention period for CloudWatch logs in days."
  type        = number
  default     = 90
}

variable "tags" {
  description = "A map of tags to apply to all resources."
  type        = map(string)
  default = {
    Environment = "Production"
    ManagedBy   = "Terraform"
  }
}
```

This `variables.tf` file defines all the necessary variables for the Terraform script, including the S3 bucket name, master account ID, KMS key alias, SNS topic name, DynamoDB table name, CloudWatch log group name, log retention period, and tags. You can customize the default values or override them when applying the Terraform configuration.