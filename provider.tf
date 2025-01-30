Based on the details provided in the Terraform script, here is the exact `provider.tf` file:

```hcl
provider "aws" {
  region = var.aws_region
}

provider "aws" {
  alias  = "master"
  region = var.aws_region
  assume_role {
    role_arn = "arn:aws:iam::${var.master_account_id}:role/OrganizationAccountAccessRole"
  }
}
```

### Explanation:
1. **Default AWS Provider**:
   - The first `provider "aws"` block sets up the default AWS provider using the `aws_region` variable.
   - This is used for creating resources in the specified AWS region.

2. **Master Account AWS Provider**:
   - The second `provider "aws"` block is configured with an alias (`master`) to assume a role in the master account.
   - The `assume_role` block specifies the ARN of the role to assume in the master account, using the `master_account_id` variable and the standard `OrganizationAccountAccessRole`.

This configuration ensures that Terraform can manage resources both in the default AWS account and in the master account of the AWS Organization.