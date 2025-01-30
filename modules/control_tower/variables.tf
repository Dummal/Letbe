variable "enable_aws_organizations" {
  type    = bool
  default = true
}

variable "aws_organization_features" {
  type    = string
  default = "ALL"
}

variable "enabled_policy_types" {
  type    = list(string)
  default = ["SERVICE_CONTROL_POLICY", "TAG_POLICY"]
}

variable "organization_services" {
  type    = list(string)
  default = [
    "cloudtrail.amazonaws.com",
    "config.amazonaws.com",
    "sso.amazonaws.com",
    "controltower.amazonaws.com"
  ]
}

variable "organizational_units" {
  type = list(object({
    name = string
    tags = map(string)
  }))
  default = [
    {
      name = "Security"
      tags = {
        Environment = "Production"
        Purpose     = "Security"
      }
    },
    {
      name = "Audit Log"
      tags = {
        Environment = "Production"
        Purpose     = "Audit"
      }
    }
  ]
}

variable "create_scp" {
  type    = bool
  default = true
}

variable "scp_name" {
  type    = string
  default = "DenyRootUser"
}

variable "scp_policy" {
  type = object({
    effect    = string
    actions   = list(string)
    principal = string
    condition = map(string)
  })
  default = {
    effect    = "Deny"
    actions   = ["*"]
    principal = "arn:aws:iam::*:root"
    condition = {}
  }
}

variable "scp_attachment_target" {
  type    = string
  default = "root"
}

variable "enable_control_tower" {
  type    = bool
  default = true
}

variable "master_account_email" {
  type = string
}

variable "control_tower_region" {
  type = string
}

variable "output_organization_ids" {
  type    = bool
  default = true
}