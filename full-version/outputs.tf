output "cloud_run_service_url" {
  value = google_cloud_run_v2_service.default.uri
}

output "storage_bucket_name" {
  value = google_storage_bucket.storage_bucket.name
}
