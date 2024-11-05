# Cloud SQL instance configuration
resource "google_sql_database_instance" "db_instance" {
  name             = "devops-db-instance"
  database_version = "POSTGRES_13" # Using PostgreSQL version 13
  region           = var.region

  settings {
    tier = "db-f1-micro" # Machine type for the DB instance
  }
}

# Create the database inside the instance
resource "google_sql_database" "database" {
  name     = "my_database"
  instance = google_sql_database_instance.db_instance.name
}

# Define a user for the database with password
resource "google_sql_user" "db_user" {
  name     = "dev_user"
  instance = google_sql_database_instance.db_instance.name
  password = var.db_password # References the sensitive password variable
}
