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
      name = "terraform-state-wudmx037m4hf5r8i744g5xaeke8p64ehzp2fqkti6d602"
      project = "devxp-339721"
}

resource "google_cloud_run_service" "cloud-run-cjkk" {
      name = "cloud-run-cjkk"
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
          }
        }
      }
      traffic {
        percent = 100
        latest_revision = true
      }
      depends_on = [google_project_service.cloud-run-cjkk-service]
}

resource "google_cloud_run_service_iam_member" "cloud-run-cjkk-iam" {
      service = google_cloud_run_service.cloud-run-cjkk.name
      location = google_cloud_run_service.cloud-run-cjkk.location
      project = google_cloud_run_service.cloud-run-cjkk.project
      role = "roles/run.invoker"
      member = "allUsers"
}

resource "google_project_service" "cloud-run-cjkk-service" {
      disable_on_destroy = false
      service = "run.googleapis.com"
}


variable = {
  CLOUD_RUN_testtest = {
    type = "string"
    sensitive = true
}

