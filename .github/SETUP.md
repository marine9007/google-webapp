# GitHub Actions Setup

## Prerequisites

You need to add your GCP service account key as a GitHub secret.

## Setup Instructions

1. **Add GCP Service Account Key to GitHub Secrets:**
   
   - Go to your repo: https://github.com/marine9007/google-webapp
   - Navigate to **Settings** → **Secrets and variables** → **Actions**
   - Click **New repository secret**
   - Name: `GCP_SA_KEY`
   - Value: Paste the entire contents of `marine9007-9cc66c0b39ee.json`
   - Click **Add secret**

2. **Workflow:**

   ### Compute Engine Workflow (`.github/workflows/compute-engine.yml`)
   - **Trigger:** Manual only (Actions tab)
   - **Actions:**
     - `plan` - Preview infrastructure changes
     - `apply` - Deploy infrastructure
     - `destroy` - Tear down infrastructure
   
   - **Steps:**
     - Format check
     - Init, validate
     - Execute selected action (plan/apply/destroy)

3. **Usage:**

   **To Plan:**
   - Go to **Actions** tab
   - Select **GCP Compute Engine**
   - Click **Run workflow**
   - Select action: `plan`
   - Click **Run workflow**

   **To Deploy:**
   - Go to **Actions** tab
   - Select **GCP Compute Engine**
   - Click **Run workflow**
   - Select action: `apply`
   - Click **Run workflow**

   **To Destroy:**
   - Go to **Actions** tab
   - Select **GCP Compute Engine**
   - Click **Run workflow**
   - Select action: `destroy`
   - **IMPORTANT:** Type `destroy` in the "confirm_destroy" field
   - Click **Run workflow**

## Best Practices

- Always run `plan` before `apply` to review changes
- Review changes locally with `terraform plan` before triggering workflows
- Use workflow actions instead of local `terraform destroy` for consistency
- Keep your service account key secure (never commit it!)
- One workflow file per GCP service (e.g., compute-engine.yml, cloud-run.yml, etc.)

## Troubleshooting

If the workflow fails:
1. Check the Actions tab for detailed logs
2. Verify `GCP_SA_KEY` secret is set correctly
3. Ensure service account has proper permissions (Editor or Compute Admin)
4. Check GCP quotas and billing status

