resource "google_storage_bucket" "terraform_backend_bucket" {
      location = "us-west1"
      name = "terraform-state-wty9j3cugaeqx6yunt27m0qdil2ksi22q2gw2dg1rxx3s"
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

