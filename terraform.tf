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
      name = "terraform-state-y08m7j728cy3y38tsui63zov2rf9x17wfxrru8440vpg8"
      project = "devxp-339721"
}

resource "google_compute_instance" "gce-mhva" {
      name = "gce-mhva"
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

resource "google_project_service" "gce-mhva-service" {
      disable_on_destroy = false
      service = "compute.googleapis.com"
}

resource "google_compute_instance" "gce-pbeo" {
      name = "gce-pbeo"
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

resource "google_project_service" "gce-pbeo-service" {
      disable_on_destroy = false
      service = "compute.googleapis.com"
}


