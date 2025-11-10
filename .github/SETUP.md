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

2. **Workflows:**

   ### Deploy Workflow (`.github/workflows/deploy.yml`)
   - **Trigger:** Manual only (Actions tab)
   
   - **Steps:**
     - Format check
     - Init, validate, plan
     - Apply infrastructure
     - Output results

   ### Destroy Workflow (`.github/workflows/destroy.yml`)
   - **Trigger:** Manual only (Actions tab)
   - **Safety:** Requires typing "destroy" to confirm
   - **Use:** Clean up infrastructure when done

3. **Manual Deploy:**
   - Go to **Actions** tab
   - Select **Deploy to GCP**
   - Click **Run workflow**
   - Choose branch
   - Click **Run workflow**

4. **Manual Destroy:**
   - Go to **Actions** tab
   - Select **Destroy GCP Infrastructure**
   - Click **Run workflow**
   - Type `destroy` in the confirmation box
   - Click **Run workflow**

## Best Practices

- Review changes locally before triggering workflows
- Always check the Actions logs after running
- Use the destroy workflow instead of local `terraform destroy` for consistency
- Keep your service account key secure (never commit it!)
- Manual triggers give you full control over when infrastructure changes

## Troubleshooting

If the workflow fails:
1. Check the Actions tab for detailed logs
2. Verify `GCP_SA_KEY` secret is set correctly
3. Ensure service account has proper permissions (Editor or Compute Admin)
4. Check GCP quotas and billing status

