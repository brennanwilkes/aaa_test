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
      name = "terraform-state-vyi5i2s17j0t8fjtzfbsio9pozhj2f1qqpqihw68in849"
      project = "devxp-339721"
}

resource "google_compute_instance" "gce-iiit" {
      name = "gce-iiit"
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
      project = "devxp-339721"
}

resource "google_project_service" "gce-iiit-service" {
      disable_on_destroy = false
      service = "compute.googleapis.com"
}


