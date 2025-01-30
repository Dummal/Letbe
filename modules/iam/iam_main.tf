Below is the `main.tf` file generated based on the provided requirements and answers:

```hcl
terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 4.0"
    }
  }
}

provider "aws" {
  region = "us-east-1" # Adjust the region as needed
}

# Variable for master account ID
variable "master_account_id" {
  description = "The AWS account ID of the master account"
  type        = string
}

# IAM Role for AFT Lambda Execution
resource "aws_iam_role" "aft_lambda_execution_role" {
  name               = "aft-lambda-execution-role"
  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Effect    = "Allow"
        Principal = {
          Service = "lambda.amazonaws.com"
        }
        Action = "sts:AssumeRole"
      }
    ]
  })

  tags = {
    Purpose   = "AFT"
    ManagedBy = "Terraform"
  }
}

resource "aws_iam_role_policy_attachment" "aft_lambda_execution_policy_attachment" {
  role       = aws_iam_role.aft_lambda_execution_role.name
  policy_arn = "arn:aws:iam::aws:policy/service-role/AWSLambdaBasicExecutionRole"
}

# IAM Role for AFT Account Provisioning
resource "aws_iam_role" "aft_account_provisioning_role" {
  name               = "aft-account-provisioning-role"
  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Effect    = "Allow"
        Principal = {
          Service = "organizations.amazonaws.com"
        }
        Action = "sts:AssumeRole"
      }
    ]
  })

  tags = {
    Purpose   = "AFT"
    ManagedBy = "Terraform"
  }
}

resource "aws_iam_policy" "aft_account_provisioning_policy" {
  name        = "aft-account-provisioning-policy"
  description = "Custom policy for AFT account provisioning operations"
  policy      = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Effect   = "Allow"
        Action   = [
          "organizations:CreateAccount",
          "organizations:ListAccounts",
          "organizations:MoveAccount",
          "iam:CreateServiceLinkedRole"
        ]
        Resource = "*"
      }
    ]
  })

  tags = {
    Purpose   = "AFT"
    ManagedBy = "Terraform"
  }
}

resource "aws_iam_role_policy_attachment" "aft_account_provisioning_policy_attachment" {
  role       = aws_iam_role.aft_account_provisioning_role.name
  policy_arn = aws_iam_policy.aft_account_provisioning_policy.arn
}

# IAM Admin Role for AFT
resource "aws_iam_role" "aft_admin_role" {
  name               = "aft-admin-role"
  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Effect    = "Allow"
        Principal = {
          AWS = "arn:aws:iam::${var.master_account_id}:root"
        }
        Action = "sts:AssumeRole"
        Condition = {
          Bool = {
            "aws:MultiFactorAuthPresent" = "true"
          }
        }
      }
    ]
  })

  tags = {
    Purpose   = "AFT"
    ManagedBy = "Terraform"
  }
}

resource "aws_iam_role_policy_attachment" "aft_admin_policy_attachment" {
  role       = aws_iam_role.aft_admin_role.name
  policy_arn = "arn:aws:iam::aws:policy/AdministratorAccess"
}

# Outputs
output "aft_lambda_execution_role_arn" {
  description = "The ARN of the AFT Lambda execution role"
  value       = aws_iam_role.aft_lambda_execution_role.arn
}

output "aft_account_provisioning_role_arn" {
  description = "The ARN of the AFT account provisioning role"
  value       = aws_iam_role.aft_account_provisioning_role.arn
}

output "aft_admin_role_arn" {
  description = "The ARN of the AFT admin role"
  value       = aws_iam_role.aft_admin_role.arn
}
```

### Explanation:
1. **Lambda Execution Role**:
   - Created with the `AWSLambdaBasicExecutionRole` policy attached.
   - Assumes the role for the Lambda service.

2. **Account Provisioning Role**:
   - Custom policy `aft-account-provisioning-policy` is created and attached.
   - Allows actions like `CreateAccount`, `ListAccounts`, `MoveAccount`, and `CreateServiceLinkedRole`.

3. **Admin Role**:
   - Grants `AdministratorAccess` but requires MFA for assuming the role.
   - Only the root user of the master account (provided via `master_account_id` variable) can assume this role.

4. **Tags**:
   - All resources are tagged with `Purpose` and `ManagedBy`.

5. **Outputs**:
   - Outputs the ARNs of the three roles for reference.