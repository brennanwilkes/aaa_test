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
      name = "terraform-state-2qqb1lfwq47jmi1xbxhh9agnvny2w0wm22nbv5opmx2p2"
      project = "devxp-339721"
}

resource "google_cloudfunctions_function" "Function-ENIT" {
      name = "Function-ENIT"
      runtime = "nodejs16"
      available_memory_mb = 128
      source_archive_bucket = google_storage_bucket.Function-ENIT-bucket.name
      source_archive_object = google_storage_bucket_object.Function-ENIT-zip.name
      trigger_http = true
      entry_point = "main"
      project = "devxp-339721"
      depends_on = [google_project_service.Function-ENIT-service]
}

resource "google_project_service" "Function-ENIT-service" {
      disable_on_destroy = false
      project = "devxp-339721"
      service = "cloudfunctions.googleapis.com"
}

resource "google_storage_bucket_object" "Function-ENIT-zip" {
      name = "source.zip#${data.archive_file.Function-ENIT-archive.output_md5}"
      bucket = google_storage_bucket.Function-ENIT-bucket.name
      source = data.archive_file.Function-ENIT-archive.output_path
}

resource "google_storage_bucket" "Function-ENIT-bucket" {
      name = "devxp-storage-bucket-for-func-function-enit"
      location = "us-west1"
      project = "devxp-339721"
}

resource "google_cloudfunctions_function_iam_member" "invoker" {
      project = google_cloudfunctions_function.Function-ENIT.project
      region = google_cloudfunctions_function.Function-ENIT.region
      cloud_function = google_cloudfunctions_function.Function-ENIT.name
      role = "roles/cloudfunctions.invoker"
      member = "allUsers"
}

data "archive_file" "Function-ENIT-archive" {
      type = "zip"
      source_dir = "./"
      output_path = "/tmp/function-Function-ENIT.zip"
}

