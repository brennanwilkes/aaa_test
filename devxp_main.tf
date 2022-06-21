terraform {
  backend "s3" {
      bucket = "terraform-state-gu6nzauqnrhpm5yjzd4n19c964ihfgpogobyqgpr4yccb"
      key = "terraform/state"
      region = "us-west-2"
  }
}





