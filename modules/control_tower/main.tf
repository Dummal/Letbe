Below is the `main.tf` file generated based on your responses:

```hcl
provider "aws" {
  region = "us-east-1" # Replace with your desired AWS region
}

resource "aws_organizations_organization" "org" {
  feature_set = "ALL"

  aws_service_access_principals = [
    "cloudtrail.amazonaws.com",
    "config.amazonaws.com",
    "sso.amazonaws.com",
    "controltower.amazonaws.com"
  ]

  enabled_policy_types = [
    "SERVICE_CONTROL_POLICY",
    "TAG_POLICY"
  ]
}

resource "aws_organizations_organizational_unit" "security" {
  name      = "Security"
  parent_id = aws_organizations_organization.org.roots[0].id

  tags = {
    Environment = "Production"
    Purpose     = "Security"
  }
}

resource "aws_organizations_organizational_unit" "audit_log" {
  name      = "Audit Log"
  parent_id = aws_organizations_organization.org.roots[0].id

  tags = {
    Environment = "Production"
    Purpose     = "Audit"
  }
}

resource "aws_organizations_policy" "deny_root_user" {
  name        = "DenyRootUser"
  description = "Deny all actions for root user"
  content     = <<POLICY
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Sid": "DenyRootUserActions",
      "Effect": "Deny",
      "Action": "*",
      "Resource": "*",
      "Condition": {
        "StringEquals": {
          "aws:PrincipalArn": "arn:aws:iam::*:root"
        }
      }
    }
  ]
}
POLICY

  type = "SERVICE_CONTROL_POLICY"
}

resource "aws_organizations_policy_attachment" "attach_deny_root_user" {
  policy_id = aws_organizations_policy.deny_root_user.id
  target_id = aws_organizations_organization.org.roots[0].id
}

output "organization_id" {
  value = aws_organizations_organization.org.id
}

output "organization_root_id" {
  value = aws_organizations_organization.org.roots[0].id
}

output "security_ou_id" {
  value = aws_organizations_organizational_unit.security.id
}

output "audit_log_ou_id" {
  value = aws_organizations_organizational_unit.audit_log.id
}

# Note: AWS Control Tower setup must be done manually after Terraform applies.
# Replace the placeholders below with your actual values for Control Tower setup.

# Control Tower setup details:
# - Master account email address: <your-master-account-email@example.com>
# - AWS region for Control Tower landing zone: <your-aws-region>
```

### Notes:
1. Replace `us-east-1` in the `provider` block with your desired AWS region.
2. Replace `<your-master-account-email@example.com>` and `<your-aws-region>` in the comments with the actual email address and region for AWS Control Tower setup.
3. AWS Control Tower cannot be fully automated with Terraform as of now. You will need to manually enable and configure Control Tower after applying this Terraform configuration.