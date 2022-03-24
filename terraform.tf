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
      name = "terraform-state-an6tsl61dnad1azmdbubmh8voie9rlh2jy9szngzypxsd"
      project = "devxp-339721"
}

resource "google_compute_instance" "GCE-pmwd-a" {
      name = "GCE-pmwd-a"
      machine_type = "f1.micro"
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

resource "google_project_service" "GCE-pmwd-a-service" {
      disable_on_destroy = false
      service = "compute.googleapis.com"
}

resource "google_compute_instance" "GCE-pmwd-b" {
      name = "GCE-pmwd-b"
      machine_type = "f1.micro"
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

resource "google_project_service" "GCE-pmwd-b-service" {
      disable_on_destroy = false
      service = "compute.googleapis.com"
}


