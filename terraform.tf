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
      name = "terraform-state-wzujdfv5hbsz8cmf986p8uqxsx8dldeluufxmd2htztjz"
      project = "devxp-339721"
}

resource "google_cloud_run_service" "cloud-run-efrd" {
      name = "cloud-run-efrd"
      location = "us-west1"
      autogenerate_revision_name = true
      template {
        spec {
          containers {
            image = "gcr.io/cloudrun/hello"

          }
        }
      }
      traffic {
        percent = 100
        latest_revision = true
      }
      depends_on = [google_project_service.cloud-run-efrd-service]
}

resource "google_cloud_run_service_iam_member" "cloud-run-efrd-iam" {
      service = google_cloud_run_service.cloud-run-efrd.name
      location = google_cloud_run_service.cloud-run-efrd.location
      project = google_cloud_run_service.cloud-run-efrd.project
      role = "roles/run.invoker"
      member = "allUsers"
}

resource "google_project_service" "cloud-run-efrd-service" {
      disable_on_destroy = false
      service = "run.googleapis.com"
}


