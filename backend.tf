resource "aws_s3_bucket" "terraform_backend_bucket" {
      bucket = "terraform-state-9rxwi9n13v5pkqmddykjimrfr91pvxzl6l81ohjfhv0an"
}

terraform {
  required_providers {
    aws =  {
    source = "hashicorp/aws"
    version = ">= 2.7.0"
    }
  }
}

