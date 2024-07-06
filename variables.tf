variable "project_id" {
  description = "The ID of the project to apply any resources to."
  type        = string
}

variable "cloud_region" {
  description = "The region to deploy to."
  type        = string
}

variable "zone" {
  description = "Cloud zone"
  type        = string
}

variable "service_name" {
  description = "Name of the Cloud Run service."
  type        = string
}

variable "image_url" {
  description = "URL of the Docker image to deploy."
  type        = string
}

variable "tz" {
  description = "Timezone."
  type        = string
}

variable "log_level" {
  description = "Log level."
  type        = string
}

variable "ai_prompt" {
  description = "AI prompt."
  type        = string
}

variable "t1_search_properties_url" {
  description = "T1 search properties URL."
  type        = string
}

variable "t1_imgs_pattern_prefix_url" {
  description = "T1 images pattern prefix URL."
  type        = string
}

variable "t1_load_timeout_in_seconds" {
  description = "T1 load timeout in seconds."
  type        = string
}

variable "t1_xpath_timeout_in_seconds" {
  description = "T1 XPath timeout in seconds."
  type        = string
}

variable "cloudamqp_url" {
  description = "CloudAMQP URL."
  type        = string
}

variable "openai_api_key" {
  description = "OpenAI API key."
  type        = string
}

variable "perplexity_api_key" {
  description = "Perplexity API key."
  type        = string
}

variable "mongodb_url" {
  description = "MongoDB URL."
  type        = string
}

variable "mongodb_database" {
  description = "MongoDB database."
  type        = string
}

variable "mongodb_user" {
  description = "MongoDB user."
  type        = string
}

variable "mongodb_password" {
  description = "MongoDB password."
  type        = string
}

variable "property_collection_name" {
  description = "Property collection name."
  type        = string
}
