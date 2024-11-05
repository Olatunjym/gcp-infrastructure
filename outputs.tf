output "database_instance_connection_name" {
  value = google_sql_database_instance.db_instance.connection_name
}

# outputs.tf
output "cloud_run_url" {
  value = google_cloud_run_service.my_service.status[0].url
}
