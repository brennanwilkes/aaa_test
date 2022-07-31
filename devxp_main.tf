terraform {
  backend "gcs" {
      bucket = "terraform-state-mnyeatwurutddb6fiauscwkvseww9fjhd71l041bw7tyq"
      prefix = "terraform/state"
  }
}

resource "google_compute_instance" "gce-ngtt" {
      name = "gce-ngtt"
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

resource "google_project_service" "gce-ngtt-service" {
      disable_on_destroy = false
      service = "compute.googleapis.com"
}




