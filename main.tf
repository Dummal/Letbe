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

module "control_tower" {
  source = "./modules/control_tower"

  enable_control_tower = var.enable_control_tower
  master_account_email = var.master_account_email
  master_account_id    = var.master_account_id
  organizational_units = var.organizational_units
  security_account_email = var.security_account_email
  audit_account_email    = var.audit_account_email

  tags = {
    Environment = "Production"
    ManagedBy   = "Terraform"
  }
}

module "iam" {
  source = "./modules/iam"

  master_account_id = var.master_account_id

  tags = {
    Environment = "Production"
    ManagedBy   = "Terraform"
  }
}

module "aws_resources" {
  source = "./modules/aws_resources"

  aft_logs_bucket_name = var.aft_logs_bucket_name

  tags = {
    Environment = "Production"
    ManagedBy   = "Terraform"
  }
}

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

This `main.tf` file includes the following:
1. **Terraform and AWS provider configuration**: Specifies the required provider and version.
2. **Control Tower module**: Sets up AWS Control Tower with organizational units and accounts.
3. **IAM module**: Creates IAM roles and policies.
4. **AWS Resources module**: Creates infrastructure resources like S3, KMS, SNS, DynamoDB, and CloudWatch.
5. **AWS Organization accounts**: Creates Dev, Prod, and Shared accounts under the Security OU.

Make sure to include the corresponding `variables.tf` and `outputs.tf` files to define the required variables and outputs for this configuration.