resource "google_storage_bucket" "storage_bucket" {
  name                        = var.bucket_name
  location                    = var.cloud_region
  project                     = var.project_id
  uniform_bucket_level_access = true

  lifecycle {
    prevent_destroy = true
  }
}

data "google_iam_policy" "storage_bucket_policy" {
  binding {
    role = "roles/storage.admin"

    members = [
      "user:${var.project_owner}",
    ]
  }
}

resource "google_storage_bucket_iam_policy" "storage_bucket_iam_policy" {
  bucket      = google_storage_bucket.storage_bucket.name
  policy_data = data.google_iam_policy.storage_bucket_policy.policy_data
}

# gsutil mb -p duckhome-firebase -c STANDARD -l southamerica-east1 gs://duckhome-etl-terraform-state
terraform {
  backend "gcs" {
    bucket = "duckhome-etl-terraform-state"
    prefix = "terraform/state"
  }
}

