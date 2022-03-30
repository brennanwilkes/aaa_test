terraform {
  required_providers {
    google =  {
    source = "hashicorp/google"
    version = ">= 4.10.0"
    }
  }
}

provider "google" {
    project = "devxp-339721"
    region = "us-west1"
}

resource "google_storage_bucket" "terraform_backend_bucket" {
      location = "us-west1"
      name = "terraform-state-e9dmuagajvw2j5xvuorib2pr8j48v6q6xbmewycrhk859"
      project = "devxp-339721"
}

resource "google_compute_instance" "gce-epxh" {
      name = "gce-epxh"
      machine_type = "n1-standard-1"
      zone = "us-west1-a"
      network_interface {
        network = "default"
      }
      boot_disk {
        initialize_params {
          image = "ubuntu-2004-focal-v20220204"
        }
      }
      project = "devxp-339721"
}

resource "google_project_service" "gce-epxh-service" {
      disable_on_destroy = false
      service = "compute.googleapis.com"
}


