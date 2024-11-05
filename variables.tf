
variable "project_id" {
  description = "The Google Cloud project ID where resources will be created"
  type        = string
}

variable "region" {
  description = "Region where GCP resources should be deployed"
  type        = string
  default     = "us-central1" # Default value
}

variable "db_password" {
  description = "Password for the database user"
  type        = string
  sensitive   = true # Sensitive information for security
}
