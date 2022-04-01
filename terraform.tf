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
      name = "terraform-state-r3s4u7q5xikz0puul7c2i5bjakgsjgq2mfxzr1ony6isz"
      project = "devxp-339721"
}

resource "google_cloud_run_service" "test-run-devxp" {
      name = "test-run-devxp"
      location = "us-west1"
      autogenerate_revision_name = true
      template {
        spec {
          containers {
            image = "gcr.io/devxp-339721/devxp:2faa0b7"
            env {
              name = "CONNECTION_STRING"
              value = var.CLOUD_RUN_CONNECTION_STRING
            }
            env {
              name = "GITHUB_CLIENT_ID"
              value = var.CLOUD_RUN_GITHUB_CLIENT_ID
            }
            env {
              name = "GITHUB_CLIENT_SECRET"
              value = var.CLOUD_RUN_GITHUB_CLIENT_SECRET
            }
          }
        }
      }
      traffic {
        percent = 100
        latest_revision = true
      }
      depends_on = [google_project_service.test-run-devxp-service]
}

resource "google_cloud_run_service_iam_member" "test-run-devxp-iam" {
      service = google_cloud_run_service.test-run-devxp.name
      location = google_cloud_run_service.test-run-devxp.location
      project = google_cloud_run_service.test-run-devxp.project
      role = "roles/run.invoker"
      member = "allUsers"
}

resource "google_project_service" "test-run-devxp-service" {
      disable_on_destroy = false
      service = "run.googleapis.com"
}


variable "CLOUD_RUN_CONNECTION_STRING" {
    type = string
    sensitive = true
}

variable "CLOUD_RUN_GITHUB_CLIENT_ID" {
    type = string
    sensitive = true
}

variable "CLOUD_RUN_GITHUB_CLIENT_SECRET" {
    type = string
    sensitive = true
}

output "test-run-devxp-service-url" {
    value = google_cloud_run_service.test-run-devxp.status[0].url
}

