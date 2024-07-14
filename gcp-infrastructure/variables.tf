variable "project_id" {
  description = "The ID of the project to apply any resources to."
  type        = string
}

variable "project_owner" {
  description = "The email of the project owner."
  type        = string
}

variable "cloud_region" {
  description = "The region to deploy to."
  type        = string
}

variable "bucket_name" {
  description = "Bucket name."
  type        = string
}
