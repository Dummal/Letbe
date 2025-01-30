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

variable "service_control_policies" {
  type = list(object({
    name       = string
    statement  = map(any)
    attachment = string
  }))
  default = [
    {
      name       = "DenyRootUser"
      statement  = {
        Effect    = "Deny"
        Action    = "*"
        Principal = "arn:aws:iam::*:root"
      }
      attachment = "root"
    }
  ]
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