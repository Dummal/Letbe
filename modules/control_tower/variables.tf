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

variable "enabled_services" {
  type    = list(string)
  default = [
    "cloudtrail.amazonaws.com",
    "config.amazonaws.com",
    "sso.amazonaws.com",
    "controltower.amazonaws.com"
  ]
}

variable "create_service_control_policy" {
  type    = bool
  default = true
}

variable "service_control_policy" {
  type = object({
    name      = string
    statement = object({
      effect    = string
      action    = list(string)
      principal = string
    })
    conditions = map(any)
  })
  default = {
    name      = "DenyRootUser"
    statement = {
      effect    = "Deny"
      action    = ["*"]
      principal = "arn:aws:iam::*:root"
    }
    conditions = {}
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
  type    = string
  default = ""
}

variable "control_tower_region" {
  type    = string
  default = ""
}

variable "output_organization_ids" {
  type    = bool
  default = true
}