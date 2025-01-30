Below is the `variables.tf` file based on the details provided in the Q&A:

```hcl
variable "master_account_id" {
  description = "The account ID of the master account that is allowed to assume the AFT admin role."
  type        = string
}

variable "tags" {
  description = "Tags to be applied to all IAM resources for identification."
  type = map(string)
  default = {
    Purpose   = "AFT"
    ManagedBy = "Terraform"
  }
}
```

This `variables.tf` file defines the `master_account_id` variable for the master account ID and a `tags` variable for tagging all IAM resources.