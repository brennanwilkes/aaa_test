resource "google_storage_bucket" "terraform_backend_bucket" {
      location = "us-west1"
      name = "terraform-state-5m7bmnhw5n6g5qutqujs3u0v88ae4bmm4iw4vuxgwkqxe"
      project = "myproject"
}

terraform {
  required_providers {
    google =  {
    source = "hashicorp/google"
    version = ">= 4.10.0"
    }
  }
}

provider "google" {
    project = "myproject"
    region = "us-west1"
}

