# Basic Web App on GCP with Terraform

Simple web application infrastructure deployed on Google Cloud Platform using Terraform.

## Prerequisites

- [Terraform](https://www.terraform.io/downloads.html) >= 1.0
- [Google Cloud SDK](https://cloud.google.com/sdk/docs/install)
- GCP Project with billing enabled

## Deployment Options

### Option 1: GitHub Actions (Recommended)

Use the automated workflow for deployment:

1. **Actions** → **GCP Compute Engine - Basic Web App** → **Run workflow**
2. Select action:
   - `plan` - Review changes without deploying
   - `apply` - Deploy infrastructure
   - `destroy` - Remove all resources (requires typing "destroy" to confirm)
3. Click **Run workflow**

The workflow provides detailed summaries including deployment vitals, access URLs, and cost information.

**Prerequisites:**
- `GCP_SA_KEY` secret must be configured (see `.github/SETUP.md`)

### Option 2: Local Terraform

1. **Authenticate with GCP:**
```bash
export GOOGLE_APPLICATION_CREDENTIALS="./your-service-account-key.json"
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
terraform plan -out=tfplan
```

5. **Deploy:**
```bash
terraform apply tfplan
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

## Workflow Security

The GitHub Actions workflow includes:
- User authorization (only `@marine9007` can run)
- Destroy confirmation required
- Concurrency control (prevents parallel runs)
- Pinned action versions (stable, no surprise updates)
- Credential isolation (secrets never exposed in logs)

See `.github/SECURITY.md` for full security documentation.

## Cleanup

**Via GitHub Actions:**
- Actions → Run workflow → Select `destroy` → Type "destroy" to confirm

**Via Local Terraform:**
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

```
```
```
 ____        _                 
/ ___| _ __ (_)_ __   ___ _ __ 
\___ \| '_ \| | '_ \ / _ \ '__|
 ___) | | | | | |_) |  __/ |   
|____/|_| |_|_| .__/ \___|_|   
              |_|              
```
