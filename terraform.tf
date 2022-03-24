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
      name = "terraform-state-g0yszp0zdp62t2o6efgoywoh2c1rdseg3nhz0du91nnyz"
      project = "devxp-339721"
}

resource "google_compute_instance" "gce-pmwd-a" {
      name = "gce-pmwd-a"
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

resource "google_project_service" "gce-pmwd-a-service" {
      disable_on_destroy = false
      service = "compute.googleapis.com"
}

resource "google_compute_instance" "gce-pmwd-b" {
      name = "gce-pmwd-b"
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

resource "google_project_service" "gce-pmwd-b-service" {
      disable_on_destroy = false
      service = "compute.googleapis.com"
}


