variable "aft_lambda_execution_role_name" {
  description = "Name of the IAM role for AFT Lambda functions to execute."
  type        = string
}

variable "aft_lambda_execution_policy_arn" {
  description = "ARN of the AWS-managed policy for AFT Lambda execution role."
  type        = string
  default     = "arn:aws:iam::aws:policy/service-role/AWSLambdaBasicExecutionRole"
}

variable "aft_account_provisioning_role_name" {
  description = "Name of the IAM role for AFT account provisioning operations."
  type        = string
}

variable "aft_account_provisioning_policy_name" {
  description = "Name of the custom policy for AFT account provisioning."
  type        = string
  default     = "aft-account-provisioning-policy"
}

variable "aft_admin_role_name" {
  description = "Name of the IAM Admin role for managing AFT."
  type        = string
}

variable "aft_admin_policy_arn" {
  description = "ARN of the AWS-managed AdministratorAccess policy for AFT admin role."
  type        = string
  default     = "arn:aws:iam::aws:policy/AdministratorAccess"
}

variable "master_account_id" {
  description = "Account ID of the master account allowed to assume the AFT admin role."
  type        = string
}

variable "iam_resource_tags" {
  description = "Tags to attach to all IAM resources for identification."
  type        = map(string)
  default     = {
    Purpose   = "AFT"
    ManagedBy = "Terraform"
  }
}