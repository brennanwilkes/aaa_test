resource "aws_s3_bucket" "terraform_backend_bucket" {
      bucket = "terraform-state-gu6nzauqnrhpm5yjzd4n19c964ihfgpogobyqgpr4yccb"
}

terraform {
  required_providers {
    aws =  {
    source = "hashicorp/aws"
    version = ">= 2.7.0"
    }
  }
}

provider "aws" {
    region = "us-west-2"
}

