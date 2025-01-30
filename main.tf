Below is the exact `main.tf` file generated based on the details provided in the {terraform script}:

```hcl
terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 4.0"
    }
  }

  required_version = ">= 1.3.0"
}

provider "aws" {
  region = var.aws_region
}

# Control Tower Module
module "control_tower" {
  source = "./modules/control_tower"

  enable_control_tower = var.enable_control_tower
  master_account_email = var.master_account_email
  master_account_id    = var.master_account_id

  organizational_units = var.organizational_units

  tags = {
    Environment = "Production"
    ManagedBy   = "Terraform"
  }
}

# IAM Module
module "iam" {
  source = "./modules/iam"

  master_account_id = var.master_account_id

  tags = {
    Environment = "Production"
    ManagedBy   = "Terraform"
  }
}

# AWS Resources Module
module "aws_resources" {
  source = "./modules/aws_resources"

  aft_logs_bucket_name = var.aft_logs_bucket_name

  tags = {
    Environment = "Production"
    ManagedBy   = "Terraform"
  }
}

# AWS Organization Accounts
resource "aws_organizations_account" "dev_account" {
  name      = "DevAccount"
  email     = var.dev_account_email
  parent_id = module.control_tower.security_ou_id

  tags = {
    Environment = "Production"
    ManagedBy   = "Terraform"
  }
}

resource "aws_organizations_account" "prod_account" {
  name      = "ProdAccount"
  email     = var.prod_account_email
  parent_id = module.control_tower.security_ou_id

  tags = {
    Environment = "Production"
    ManagedBy   = "Terraform"
  }
}

resource "aws_organizations_account" "shared_account" {
  name      = "SharedAccount"
  email     = var.shared_account_email
  parent_id = module.control_tower.security_ou_id

  tags = {
    Environment = "Production"
    ManagedBy   = "Terraform"
  }
}
```

This `main.tf` file includes the setup for the Control Tower, IAM, and AWS resources modules, as well as the creation of AWS Organization accounts (Dev, Prod, and Shared). It also ensures that all resources are tagged appropriately for identification and management.