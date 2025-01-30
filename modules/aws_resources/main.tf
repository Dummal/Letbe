Below is the `main.tf` file generated based on the requirements and answers provided:

```hcl
terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 4.0"
    }
  }

  required_version = ">= 1.3.0"
}

provider "aws" {
  region = var.aws_region
}

# Variables
variable "s3_bucket_name" {
  description = "Name of the S3 bucket for AFT logs"
  type        = string
}

variable "master_account_id" {
  description = "AWS Master Account ID"
  type        = string
}

variable "aws_region" {
  description = "AWS Region"
  type        = string
  default     = "us-east-1"
}

# S3 Bucket for AFT Logs
resource "aws_s3_bucket" "aft_logs" {
  bucket = var.s3_bucket_name

  versioning {
    enabled = true
  }

  server_side_encryption_configuration {
    rule {
      apply_server_side_encryption_by_default {
        sse_algorithm     = "aws:kms"
        kms_master_key_id = aws_kms_key.aft_key.arn
      }
    }
  }

  public_access_block_configuration {
    block_public_acls       = true
    block_public_policy     = true
    ignore_public_acls      = true
    restrict_public_buckets = true
  }

  tags = {
    Environment = "Production"
    ManagedBy   = "Terraform"
    Name        = "AFT Logs"
  }
}

# KMS Key for Encryption
resource "aws_kms_key" "aft_key" {
  description             = "KMS key for encrypting AFT resources"
  enable_key_rotation     = true
  deletion_window_in_days = 30

  policy = jsonencode({
    Version   = "2012-10-17"
    Statement = [
      {
        Sid       = "AllowRootAccountAccess"
        Effect    = "Allow"
        Principal = {
          AWS = "arn:aws:iam::${var.master_account_id}:root"
        }
        Action    = "kms:*"
        Resource  = "*"
      },
      {
        Sid       = "AllowCloudWatchLogsAccess"
        Effect    = "Allow"
        Principal = {
          Service = "logs.${var.aws_region}.amazonaws.com"
        }
        Action    = [
          "kms:Encrypt",
          "kms:Decrypt",
          "kms:ReEncrypt*",
          "kms:GenerateDataKey*",
          "kms:DescribeKey"
        ]
        Resource  = "*"
      }
    ]
  })

  tags = {
    Environment = "Production"
    ManagedBy   = "Terraform"
    Name        = "AFT KMS Key"
  }
}

resource "aws_kms_alias" "aft_key_alias" {
  name          = "alias/aft-key"
  target_key_id = aws_kms_key.aft_key.id
}

# SNS Topic for Notifications
resource "aws_sns_topic" "aft_notifications" {
  name = "aft-notifications"

  kms_master_key_id = aws_kms_key.aft_key.arn

  tags = {
    Environment = "Production"
    ManagedBy   = "Terraform"
    Name        = "AFT Notifications"
  }
}

# DynamoDB Table for AFT Requests
resource "aws_dynamodb_table" "aft_requests" {
  name           = "aft-requests"
  billing_mode   = "PAY_PER_REQUEST"
  hash_key       = "id"

  attribute {
    name = "id"
    type = "S"
  }

  server_side_encryption {
    enabled     = true
    kms_key_arn = aws_kms_key.aft_key.arn
  }

  point_in_time_recovery {
    enabled = true
  }

  tags = {
    Environment = "Production"
    ManagedBy   = "Terraform"
    Name        = "AFT Requests"
  }
}

# CloudWatch Log Group for AFT Logs
resource "aws_cloudwatch_log_group" "aft_logs" {
  name              = "/aws/aft/logs"
  retention_in_days = 90
  kms_key_id        = aws_kms_key.aft_key.arn

  tags = {
    Environment = "Production"
    ManagedBy   = "Terraform"
    Name        = "AFT Logs"
  }
}

# Outputs
output "s3_bucket_id" {
  description = "ID of the S3 bucket for AFT logs"
  value       = aws_s3_bucket.aft_logs.id
}

output "kms_key_arn" {
  description = "ARN of the KMS key"
  value       = aws_kms_key.aft_key.arn
}

output "sns_topic_arn" {
  description = "ARN of the SNS topic for notifications"
  value       = aws_sns_topic.aft_notifications.arn
}

output "dynamodb_table_name" {
  description = "Name of the DynamoDB table for AFT requests"
  value       = aws_dynamodb_table.aft_requests.name
}
```

### Explanation:
1. **S3 Bucket**: Configured with versioning, server-side encryption using KMS, and public access blocked.
2. **KMS Key**: Created with key rotation enabled and a policy allowing access to the master account and CloudWatch Logs service.
3. **SNS Topic**: Encrypted with the KMS key and named `aft-notifications`.
4. **DynamoDB Table**: Configured with a hash key (`id`), server-side encryption using the KMS key, and point-in-time recovery enabled.
5. **CloudWatch Log Group**: Configured with a 90-day retention period and encrypted using the KMS key.
6. **Tags**: Applied to all resources for identification.
7. **Outputs**: Key outputs for the S3 bucket ID, KMS key ARN, SNS topic ARN, and DynamoDB table name are provided.
8. **Variables**: The S3 bucket name, master account ID, and AWS region are parameterized for flexibility.