variable "aft_lambda_execution_role_name" {
  description = "The name of the IAM role for AFT Lambda functions to execute."
  type        = string
}

variable "aft_lambda_execution_policy_arn" {
  description = "The ARN of the AWS-managed policy to attach to the AFT Lambda execution role."
  type        = string
  default     = "arn:aws:iam::aws:policy/service-role/AWSLambdaBasicExecutionRole"
}

variable "aft_account_provisioning_role_name" {
  description = "The name of the IAM role for AFT account provisioning operations in AWS Organizations."
  type        = string
}

variable "aft_account_provisioning_policy_name" {
  description = "The name of the custom policy for AFT account provisioning."
  type        = string
  default     = "aft-account-provisioning-policy"
}

variable "aft_account_provisioning_policy_document" {
  description = "The JSON policy document for the AFT account provisioning role."
  type        = string
}

variable "aft_admin_role_name" {
  description = "The name of the IAM Admin role for managing AFT."
  type        = string
}

variable "aft_admin_policy_arn" {
  description = "The ARN of the AWS-managed AdministratorAccess policy to attach to the AFT admin role."
  type        = string
  default     = "arn:aws:iam::aws:policy/AdministratorAccess"
}

variable "aft_admin_role_mfa_required" {
  description = "Indicates whether MFA is required to assume the AFT admin role."
  type        = bool
  default     = true
}

variable "master_account_id" {
  description = "The account ID of the master account allowed to assume the AFT admin role."
  type        = string
}

variable "iam_resource_tags" {
  description = "Tags to attach to all IAM resources for identification."
  type        = map(string)
  default     = {
    Purpose    = "AFT"
    ManagedBy  = "Terraform"
  }
}