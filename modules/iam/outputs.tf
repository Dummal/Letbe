Here is the exact `outputs.tf` file based on the provided details:

```hcl
output "aft_lambda_execution_role_arn" {
  description = "The ARN of the IAM role for AFT Lambda execution."
  value       = aws_iam_role.aft_lambda_execution_role.arn
}

output "aft_account_provisioning_role_arn" {
  description = "The ARN of the IAM role for AFT account provisioning operations."
  value       = aws_iam_role.aft_account_provisioning_role.arn
}

output "aft_admin_role_arn" {
  description = "The ARN of the IAM role for AFT administration."
  value       = aws_iam_role.aft_admin_role.arn
}
```

This file outputs the ARNs of the three IAM roles: the AFT Lambda execution role, the AFT account provisioning role, and the AFT admin role. Each output includes a description for clarity.