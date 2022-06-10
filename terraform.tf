terraform {
  backend "gcs" {
      bucket = "terraform-state-wty9j3cugaeqx6yunt27m0qdil2ksi22q2gw2dg1rxx3s"
      prefix = "terraform/state"
  }
}

provider "google" {
    project = "myproject"
    region = "us-west1"
}

resource "google_compute_instance" "gce-wkny" {
      name = "gce-wkny"
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
      project = "myproject"
}

resource "google_project_service" "gce-wkny-service" {
      disable_on_destroy = false
      service = "compute.googleapis.com"
}




