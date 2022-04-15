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
      name = "terraform-state-y6553s5yyz00hflq7tcjxwgcmfyf848knlutj6dtfewil"
      project = "myproject-440810"
}

resource "google_compute_instance" "gce-pizr" {
      name = "gce-pizr"
      machine_type = "f1-micro"
      zone = "us-west1-a"
      network_interface {
        network = "default"
      }
      boot_disk {
        initialize_params {
          image = "ubuntu-2004-focal-v20220204"
        }
      }
      project = "myproject-440810"
}

resource "google_project_service" "gce-pizr-service" {
      disable_on_destroy = false
      service = "compute.googleapis.com"
}




