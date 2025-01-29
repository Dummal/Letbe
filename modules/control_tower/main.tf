resource "aws_organizations_organization" "this" {
  feature_set = "ALL"
}

resource "aws_organizations_policy" "deny_root_user" {
  name        = "DenyRootUser"
  description = "Deny all actions for root user"
  content     = jsonencode({
    Version   = "2012-10-17",
    Statement = [
      {
        Effect    = "Deny",
        Action    = "*",
        Resource  = "*",
        Principal = {
          AWS = "arn:aws:iam::*:root"
        }
      }
    ]
  })
  type = "SERVICE_CONTROL_POLICY"
}

resource "aws_organizations_policy_attachment" "deny_root_user_attachment" {
  policy_id = aws_organizations_policy.deny_root_user.id
  target_id = aws_organizations_organization.this.roots[0].id
}

resource "aws_organizations_organizational_unit" "security" {
  name      = "Security"
  parent_id = aws_organizations_organization.this.roots[0].id
  tags = {
    Environment = "Production"
    Purpose     = "Security"
  }
}

resource "aws_organizations_organizational_unit" "audit_log" {
  name      = "Audit Log"
  parent_id = aws_organizations_organization.this.roots[0].id
  tags = {
    Environment = "Production"
    Purpose     = "Audit"
  }
}