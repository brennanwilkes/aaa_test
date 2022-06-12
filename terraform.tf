terraform {
  backend "s3" {
      bucket = "terraform-state-le087d2qndi3e6ehpz0tzdc3z8ojd35su7sybzbtl3sep"
      key = "terraform/state"
      region = "us-west-2"
  }
}

provider "aws" {
    region = "us-west-2"
}

resource = []



