resource "google_cloud_run_v2_service" "default" {

  depends_on = [
    google_service_account_iam_member.iam_member,
    google_service_account_iam_binding.act_as_iam,
  ]

  name     = var.service_name
  location = var.cloud_region
  project  = var.project_id

  template {
    service_account = var.service_name
  }

}

data "google_project" "project" {
  project_id = var.project_id
}

resource "google_service_account" "default_service_account" {
  account_id   = var.service_name
  display_name = var.service_name
  project      = data.google_project.project.project_id
}

resource "google_service_account_iam_binding" "act_as_iam" {
  service_account_id = google_service_account.default_service_account.name
  role               = "roles/iam.serviceAccountUser"
  members = [
    "serviceAccount:${google_service_account.default_service_account.email}",
  ]
}

resource "google_service_account_iam_member" "iam_member" {
  service_account_id = google_service_account.default_service_account.name
  role               = "roles/iam.serviceAccountUser"
  member             = "serviceAccount:${google_service_account.default_service_account.email}"
}

resource "google_storage_bucket" "storage_bucket" {
  name                        = var.bucket_name
  location                    = google_cloud_run_v2_service.default.location
  project                     = var.project_id
  force_destroy               = true
  uniform_bucket_level_access = true
}

data "google_iam_policy" "storage_bucket_policy" {
  binding {
    role = "roles/storage.admin"

    members = [
      "serviceAccount:${google_service_account.default_service_account.email}",
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
