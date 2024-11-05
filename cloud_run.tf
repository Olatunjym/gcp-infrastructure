resource "google_cloud_run_service" "my_service" {
  name     = "my-cloud-run-service"
  location = var.region

  template {
    spec {
      containers {
        image = "gcr.io/${var.project_id}/my-cloud-run-image:latest" # Replace with your container image path

        resources {
          limits = {
            memory = "512Mi"
            cpu    = "1"
          }
        }
      }
    }
  }

  traffic {
    percent         = 100
    latest_revision = true
  }
}

# Allowing public access to the Cloud Run service
resource "google_cloud_run_service_iam_member" "invoker" {
  service  = google_cloud_run_service.my_service.name
  location = google_cloud_run_service.my_service.location
  role     = "roles/run.invoker"
  member   = "allUsers" # Allows public access
}