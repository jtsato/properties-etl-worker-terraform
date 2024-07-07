resource "google_cloud_run_v2_service" "default" {
  name     = var.service_name
  location = var.cloud_region
  project  = var.project_id

  template {
    containers {
      image = var.image_url

      ports {
        container_port = 3000
      }

      resources {
        limits = {
          memory = "1024Mi"
          cpu    = 1
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

    scaling {
      min_instance_count = 1
      max_instance_count = 3
    }

    service_account = var.service_name
  }

  traffic {
    type    = "TRAFFIC_TARGET_ALLOCATION_TYPE_LATEST"
    percent = 100
  }
  
}