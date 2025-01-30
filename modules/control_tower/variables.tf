Below is the `variables.tf` file based on the provided user inputs:

```hcl
variable "enable_aws_organizations" {
  description = "Enable AWS Organizations and create an organization"
  type        = bool
  default     = true
}

variable "aws_services_to_integrate" {
  description = "List of AWS services to integrate with the organization"
  type        = list(string)
  default     = [
    "cloudtrail.amazonaws.com",
    "config.amazonaws.com",
    "sso.amazonaws.com",
    "controltower.amazonaws.com"
  ]
}

variable "organization_feature_set" {
  description = "Feature set for AWS Organizations"
  type        = string
  default     = "ALL"
}

variable "enabled_policy_types" {
  description = "Policy types to enable in the organization"
  type        = list(string)
  default     = [
    "SERVICE_CONTROL_POLICY",
    "TAG_POLICY"
  ]
}

variable "organizational_units" {
  description = "List of Organizational Units (OUs) to create"
  type        = list(string)
  default     = [
    "Security",
    "Audit Log"
  ]
}

variable "ou_tags" {
  description = "Tags to add to Organizational Units (OUs)"
  type        = map(map(string))
  default     = {
    "Security" = {
      "Environment" = "Production",
      "Purpose"     = "Security"
    }
    "Audit Log" = {
      "Environment" = "Production",
      "Purpose"     = "Audit"
    }
  }
}

variable "create_scp" {
  description = "Whether to create a Service Control Policy (SCP)"
  type        = bool
  default     = true
}

variable "scp_name" {
  description = "Name of the Service Control Policy (SCP)"
  type        = string
  default     = "DenyRootUser"
}

variable "scp_policy" {
  description = "Policy document for the Service Control Policy (SCP)"
  type        = string
  default     = jsonencode({
    "Version"   : "2012-10-17",
    "Statement" : [
      {
        "Effect"    : "Deny",
        "Action"    : "*",
        "Resource"  : "*",
        "Condition" : {
          "StringEquals" : {
            "aws:PrincipalArn" : "arn:aws:iam::*:root"
          }
        }
      }
    ]
  })
}

variable "scp_attachment_target" {
  description = "Where to attach the Service Control Policy (SCP)"
  type        = string
  default     = "root"
}

variable "enable_control_tower" {
  description = "Enable AWS Control Tower"
  type        = bool
  default     = true
}

variable "master_account_email" {
  description = "Email address for the master account"
  type        = string
}

variable "control_tower_region" {
  description = "AWS region to deploy the Control Tower landing zone"
  type        = string
}

variable "output_organization_ids" {
  description = "Whether to output organization and OU IDs"
  type        = bool
  default     = true
}

variable "manual_control_tower_setup" {
  description = "Whether Control Tower setup should be manually enabled after Terraform applies"
  type        = bool
  default     = true
}
```

This `variables.tf` file defines all the necessary variables based on the user inputs, including default values where applicable. You can use this file in your Terraform configuration to parameterize the setup.