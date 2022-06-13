resource "aws_s3_bucket" "terraform_backend_bucket" {
      bucket = "terraform-state-8abgyu1531iuxlohl6dog6r3j0slg7t4eny2eq8wwj577"
}

terraform {
  required_providers {
    aws =  {
    source = "hashicorp/aws"
    version = ">= 2.7.0"
    }
  }
}

