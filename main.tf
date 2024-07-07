resource "google_cloud_run_service" "default" {

  depends_on = [
    google_service_account_iam_member.iam_member,
    google_service_account_iam_binding.act_as_iam,
  ]

  name     = var.service_name
  location = var.cloud_region
  project  = var.project_id

  template {
    spec {
      service_account_name = var.service_name

      containers {
        image = var.image_url

        ports {
          container_port = 8000
        }

        resources {
          limits = {
            memory = "1024Mi"
          }
        }

        env {
          name  = "TZ"
          value = var.tz
        }
        env {
          name  = "LOG_LEVEL"
          value = var.log_level
        }
        env {
          name  = "AI_PROMPT"
          value = var.ai_prompt
        }
        env {
          name  = "T1_SEARCH_PROPERTIES_URL"
          value = var.t1_search_properties_url
        }
        env {
          name  = "T1_IMGS_PATTERN_PREFIX_URL"
          value = var.t1_imgs_pattern_prefix_url
        }
        env {
          name  = "T1_LOAD_TIMEOUT_IN_SECONDS"
          value = var.t1_load_timeout_in_seconds
        }
        env {
          name  = "T1_XPATH_TIMEOUT_IN_SECONDS"
          value = var.t1_xpath_timeout_in_seconds
        }
        env {
          name  = "CLOUDAMQP_URL"
          value = var.cloudamqp_url
        }
        env {
          name  = "OPENAI_API_KEY"
          value = var.openai_api_key
        }
        env {
          name  = "PERPLEXITY_API_KEY"
          value = var.perplexity_api_key
        }
        env {
          name  = "MONGODB_URL"
          value = var.mongodb_url
        }
        env {
          name  = "MONGODB_DATABASE"
          value = var.mongodb_database
        }
        env {
          name  = "MONGODB_USER"
          value = var.mongodb_user
        }
        env {
          name  = "MONGODB_PASSWORD"
          value = var.mongodb_password
        }
        env {
          name  = "PROPERTY_COLLECTION_NAME"
          value = var.property_collection_name
        }

      }
    }
    metadata {
      annotations = {
        "autoscaling.knative.dev/maxScale" = "3",
      }
    }
  }

  traffic {
    percent         = 100
    latest_revision = true
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

data "google_iam_policy" "noauth" {
  binding {
    role = "roles/run.invoker"

    members = [
      "allUsers",
    ]
  }
}

resource "google_cloud_run_service_iam_policy" "noauth" {
  project  = google_cloud_run_service.default.project
  service  = google_cloud_run_service.default.name
  location = google_cloud_run_service.default.location

  policy_data = data.google_iam_policy.noauth.policy_data
}

# gsutil mb -p duckhome-firebase -c STANDARD -l southamerica-east1 gs://duckhome-etl-terraform-state
terraform {
  backend "gcs" {
    bucket = "duckhome-etl-terraform-state"
    prefix = "terraform/state"
  }
}
