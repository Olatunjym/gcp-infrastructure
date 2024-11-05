# provider.tf
provider "google" {
  project = var.project_id # Specifies the GCP project ID
  region  = var.region     # Specifies the region for your resources
}
