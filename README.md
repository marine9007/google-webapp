# Basic Web App on GCP with Terraform

Simple web application infrastructure deployed on Google Cloud Platform using Terraform.

## Prerequisites

- [Terraform](https://www.terraform.io/downloads.html) >= 1.0
- [Google Cloud SDK](https://cloud.google.com/sdk/docs/install)
- GCP Project with billing enabled

## Setup

1. **Authenticate with GCP:**
```bash
gcloud auth application-default login
gcloud config set project marine9007
```

2. **Enable required APIs:**
```bash
gcloud services enable compute.googleapis.com
```

3. **Initialize Terraform:**
```bash
terraform init
```

4. **Review the plan:**
```bash
terraform plan
```

5. **Deploy:**
```bash
terraform apply
```

6. **Access your web app:**
The URL will be displayed in the outputs after deployment.

## Resources Created

- VPC Network
- Firewall rules (HTTP/HTTPS/SSH)
- Ephemeral public IP (free)
- Compute Engine instance (e2-micro - FREE TIER)
- Nginx web server

## Free Tier

This configuration uses GCP Always Free resources:
- 1x e2-micro instance per month (in us-west1, us-central1, or us-east1)
- 30 GB standard persistent disk
- 1 GB network egress per month

Keep this as your ONLY e2-micro instance in these regions to stay 100% free.

## Cleanup

```bash
terraform destroy
```

## Customization

Edit `variables.tf` or create a `terraform.tfvars` file:

```hcl
project_id   = "your-project-id"
region       = "us-east1"
zone         = "us-east1-b"
machine_type = "e2-small"
```

