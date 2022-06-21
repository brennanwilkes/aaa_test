resource "google_storage_bucket" "terraform_backend_bucket" {
      location = "us-west1"
      name = "terraform-state-mnyeatwurutddb6fiauscwkvseww9fjhd71l041bw7tyq"
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

