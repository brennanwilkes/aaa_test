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
      name = "terraform-state-1m1uwtt24nbt9tq840k57h8c2vblgnwkogl3n3uvqz38b"
      project = "myproject-440810"
}




