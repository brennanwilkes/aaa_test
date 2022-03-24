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
      name = "terraform-state-77jle8ly0ieydpbipql3p5v65xglduijk0bngofjt9ltc"
      project = "devxp-339721"
}

resource "google_cloudfunctions_function" "GoogleFunction-ENIT" {
      name = "GoogleFunction-ENIT"
      runtime = "nodejs16"
      available_memory_mb = 128
      source_archive_bucket = google_storage_bucket.GoogleFunction-ENIT-bucket.name
      source_archive_object = google_storage_bucket_object.GoogleFunction-ENIT-zip.name
      trigger_http = true
      entry_point = "main"
      project = "devxp-339721"
      depends_on = [google_project_service.GoogleFunction-ENIT-service]
}

resource "google_project_service" "GoogleFunction-ENIT-service" {
      disable_on_destroy = false
      project = "devxp-339721"
      service = "cloudfunctions.googleapis.com"
}

resource "google_storage_bucket_object" "GoogleFunction-ENIT-zip" {
      name = "source.zip#${data.archive_file.GoogleFunction-ENIT-archive.output_md5}"
      bucket = google_storage_bucket.GoogleFunction-ENIT-bucket.name
      source = data.archive_file.GoogleFunction-ENIT-archive.output_path
}

resource "google_storage_bucket" "GoogleFunction-ENIT-bucket" {
      name = "googlefunction-enit-devxp-storage-bucket-for-func"
      location = "us-west1"
      project = "devxp-339721"
}

resource "google_cloudfunctions_function_iam_member" "invoker" {
      project = google_cloudfunctions_function.GoogleFunction-ENIT.project
      region = google_cloudfunctions_function.GoogleFunction-ENIT.region
      cloud_function = google_cloudfunctions_function.GoogleFunction-ENIT.name
      role = "roles/cloudfunctions.invoker"
      member = "allUsers"
}

data "archive_file" "GoogleFunction-ENIT-archive" {
      type = "zip"
      source_dir = "./"
      output_path = "/tmp/function-GoogleFunction-ENIT.zip"
}

