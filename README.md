GCP Infrastructure Setup with Terraform

## Overview

This Terraform configuration sets up infrastructure on Google Cloud Platform (GCP) for a new service, including:
- A **Cloud SQL Database** (PostgreSQL)
- A **Cloud Run Service** for deploying containerized applications
- An **External HTTP Load Balancer** to route traffic to the Cloud Run service

## Prerequisites

- **Google Cloud Project**: You must have a GCP project where this infrastructure will be deployed.
- **Google Cloud SDK**: Installed and configured on your local machine or CI/CD environment.
- **Terraform**: Version 1.x or above is recommended.

## Configuration Files

The following `.tf` files define the infrastructure:

- `provider.tf`: Configures the GCP provider.
- `variables.tf`: Defines input variables for customization.
- `db.tf`: Creates and configures a Cloud SQL instance.
- `cloud_run.tf`: Defines a Cloud Run service and sets IAM policies for public access.
- `load_balancer.tf`: Configures an external HTTP load balancer for traffic distribution.
- `outputs.tf`: Exposes useful output values, like the database connection string and Cloud Run URL.

## Usage Instructions

### Step 1: Clone the Repository

Clone this repository to your local machine or fork it in your GitHub account.

```bash
git clone <repository_url>
cd <repository_directory>
```

### Step 2: Set Up Input Variables

1. **Create a `terraform.tfvars` File**: This file will hold sensitive and project-specific values.
2. **Define Required Variables** in `terraform.tfvars`:

   ```hcl
   project_id = "your-gcp-project-id"
   region     = "your-preferred-region"  # e.g., "us-central1"
   db_password = "your-secure-db-password"
   ```

   **Note**: This file should not be submitted to version control if it contains sensitive information.

### Step 3: Initialize Terraform

Initialize the Terraform project to download required provider plugins:

```bash
terraform init
```

### Step 4: Plan the Deployment

Run `terraform plan` to review the infrastructure changes that Terraform will make. This step lets you confirm that everything is set up as expected without actually creating resources.

```bash
terraform plan
```

### Step 5: Apply the Configuration

Once you are satisfied with the plan, run `terraform apply` to create the infrastructure on GCP. Review the proposed changes and confirm by typing `yes` when prompted.

```bash
terraform apply
```

## Explanation of Each Resource

### 1. Cloud SQL Database (`db.tf`)
- **Database Instance**: Creates a Cloud SQL instance using PostgreSQL 13.
- **Database**: Sets up an initial database within the instance.
- **Database User**: Configures a user for the database with a password (from `db_password` variable).

### 2. Cloud Run Service (`cloud_run.tf`)
- Deploys a Cloud Run service using a Docker image (replace `gcr.io/${var.project_id}/my-cloud-run-image:latest` with your actual image path).
- **Public Access**: Sets up an IAM policy to allow all users to access the Cloud Run service.

### 3. Load Balancer (`load_balancer.tf`)
- **URL Map**: Routes requests to the Cloud Run service.
- **HTTP Proxy**: Configures an HTTP proxy to manage requests.
- **Global Forwarding Rule**: Sets up a rule to listen on port 80 and forward traffic to the proxy.

## Outputs

After a successful run, Terraform will output:
- **Database Instance Connection Name**: Use this to connect applications to the database.
- **Cloud Run URL**: This is the public URL of the Cloud Run service, accessible via the load balancer.

## Clean-Up

To destroy all created resources and avoid incurring costs, run:

```bash
terraform destroy
```

### Notes

- **Placeholder Values**: Ensure `terraform.tfvars` contains real project values and that sensitive values like `db_password` are securely managed.
- **Deleting `terraform.tfvars`**: Remove `terraform.tfvars` if you’re sharing or submitting the project to avoid exposing sensitive data.
- **Replace Cloud Run Image**: Update the image in `cloud_run.tf` with an actual image path in GCP Container Registry or Artifact Registry.

---

## Troubleshooting

- **Provider Errors**: Ensure `project_id` and `region` are correctly set in `terraform.tfvars`.
- **Cloud Run Image Not Found**: Update `image` in `cloud_run.tf` with a valid container image in Container Registry or Artifact Registry.

---

