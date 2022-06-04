terraform {
  required_providers {
    google =  {
    source = "hashicorp/google"
    version = ">= 4.10.0"
    }
  }
}

provider "google" {
    project = "myproject"
    region = "us-west1"
}

resource "google_storage_bucket" "terraform_backend_bucket" {
      location = "us-west1"
      name = "terraform-state-ndef6ahvu37g8ojc3oiwt1fbqs3hjflub4vj2unrzv7og"
      project = "myproject"
}

resource "google_cloudfunctions_function" "Function-tuvk" {
      name = "Function-tuvk"
      runtime = "nodejs16"
      available_memory_mb = 128
      source_archive_bucket = google_storage_bucket.Function-tuvk-bucket.name
      source_archive_object = google_storage_bucket_object.Function-tuvk-zip.name
      trigger_http = true
      entry_point = "main"
      project = "myproject"
      depends_on = [google_project_service.Function-tuvk-service]
}

resource "google_project_service" "Function-tuvk-service" {
      disable_on_destroy = false
      project = "myproject"
      service = "cloudfunctions.googleapis.com"
}

resource "google_storage_bucket_object" "Function-tuvk-zip" {
      name = "source.zip#${data.archive_file.Function-tuvk-archive.output_md5}"
      bucket = google_storage_bucket.Function-tuvk-bucket.name
      source = data.archive_file.Function-tuvk-archive.output_path
}

resource "google_storage_bucket" "Function-tuvk-bucket" {
      name = "devxp-storage-bucket-for-func-function-tuvk"
      location = "us-west1"
      project = "myproject"
}

resource "google_cloudfunctions_function_iam_member" "invoker" {
      project = google_cloudfunctions_function.Function-tuvk.project
      region = google_cloudfunctions_function.Function-tuvk.region
      cloud_function = google_cloudfunctions_function.Function-tuvk.name
      role = "roles/cloudfunctions.invoker"
      member = "allUsers"
}

data "archive_file" "Function-tuvk-archive" {
      type = "zip"
      source_dir = "./"
      output_path = "/tmp/function-Function-tuvk.zip"
}



