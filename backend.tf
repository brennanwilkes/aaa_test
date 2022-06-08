terraform {
  backend "s3" {
    bucket = "terraform-state-9rxwi9n13v5pkqmddykjimrfr91pvxzl6l81ohjfhv0an"
    key = "terraform/state"
    region = "us-west-2"

  }
  required_providers{
    aws = {
      source = "hashicorp/aws"      version = ">= 2.7.0"
    }
  }
}
