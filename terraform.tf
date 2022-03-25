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
      name = "terraform-state-9lw4bfuqgav9fqual8oblostxepchhccpbe09mn2cpj5s"
      project = "devxp-339721"
}

resource "google_cloud_run_service" "cloud-run-lele" {
      name = "cloud-run-lele"
      location = "us-west1"
      autogenerate_revision_name = true
      template {
        spec {
          containers {
            image = "gcr.io/cloudrun/hello"
            env {
              name = "testtest"
              value = var.CLOUD_RUN_testtest
            }
            env {
              name = "testtesttest"
              value = var.CLOUD_RUN_testtesttest
            }
          }
        }
      }
      traffic {
        percent = 100
        latest_revision = true
      }
      depends_on = [google_project_service.cloud-run-lele-service]
}

resource "google_cloud_run_service_iam_member" "cloud-run-lele-iam" {
      service = google_cloud_run_service.cloud-run-lele.name
      location = google_cloud_run_service.cloud-run-lele.location
      project = google_cloud_run_service.cloud-run-lele.project
      role = "roles/run.invoker"
      member = "allUsers"
}

resource "google_project_service" "cloud-run-lele-service" {
      disable_on_destroy = false
      service = "run.googleapis.com"
}


variable "CLOUD_RUN_testtest" {
    type = "string"
    sensitive = true
}

variable "CLOUD_RUN_testtesttest" {
    type = "string"
    sensitive = true
}

