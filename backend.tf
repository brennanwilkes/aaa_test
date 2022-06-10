resource "aws_s3_bucket" "terraform_backend_bucket" {
      bucket = "terraform-state-le087d2qndi3e6ehpz0tzdc3z8ojd35su7sybzbtl3sep"
}

terraform {
  required_providers {
    aws =  {
    source = "hashicorp/aws"
    version = ">= 2.7.0"
    }
  }
}

