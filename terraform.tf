terraform {
  required_providers {
    google =  {
    source = "hashicorp/google"
    version = ">= 4.10.0"
    }
  }
}

provider "google" {
    project = "myproject-440810"
    region = "us-west1"
}

resource "google_storage_bucket" "terraform_backend_bucket" {
      location = "us-west1"
      name = "terraform-state-5sn7kgg91q9dzpvoiyb80rryiop7jignano2bjdb8iny5"
      project = "myproject-440810"
}




