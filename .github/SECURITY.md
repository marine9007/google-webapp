# Security

## Workflow Security

### Access Control
- ✅ **User Authorization**: Only `@marine9007` can run workflows
- ✅ **Destroy Protection**: Requires typing "destroy" to confirm
- ✅ **Manual Triggers Only**: No automatic deployments on push/PR
- ✅ **Concurrency Control**: Prevents parallel runs that could corrupt state

### Secrets Management
- ✅ **GCP_SA_KEY**: Service account JSON stored as GitHub secret
- ✅ **Credential Isolation**: Auth credentials not exported to environment
- ✅ **No Hardcoded Secrets**: All sensitive data in GitHub Secrets

### Permissions
- ✅ **Least Privilege**: Workflow only has `contents: read` and `id-token: write`
- ✅ **Fork Protection**: Forks cannot access secrets (GitHub default)
- ✅ **Service Account**: Should have minimal GCP permissions (Editor or Compute Admin only)

## Important Files Protected

### .gitignore Protection
The following sensitive files are ignored:
- `*.json` - Prevents committing service account keys
- `*.tfvars` - Prevents committing variable files (except .example)
- `*.tfstate*` - Prevents committing Terraform state
- `.terraform/` - Prevents committing provider binaries

### Verify Before Committing
Always run:
```bash
git status
git diff
```

Before committing to ensure no sensitive data is staged.

## Service Account Security

### Current Setup
- **Type**: GCP Service Account
- **File**: `marine9007-9cc66c0b39ee.json` (LOCAL ONLY - never commit!)
- **Stored**: GitHub Secrets as `GCP_SA_KEY`

### Best Practices
1. **Rotate Keys Regularly**: Every 90 days minimum
2. **Use Workload Identity** (advanced): Better than long-lived keys
3. **Limit Permissions**: Only grant what's needed:
   - `roles/compute.admin` - For Compute Engine
   - `roles/compute.networkAdmin` - For VPC/Firewall
   - Or use `roles/editor` (broader, but easier for demos)

### Rotating Service Account Key

1. **Create new key** in GCP Console:
   - IAM → Service Accounts → Actions → Manage Keys
   - Add Key → Create New Key → JSON

2. **Update GitHub Secret**:
   - Repo Settings → Secrets → Actions
   - Update `GCP_SA_KEY` with new JSON contents

3. **Delete old key** in GCP Console

## Public Repository Considerations

### What's Safe to Expose
- ✅ Terraform configuration (infrastructure as code)
- ✅ Workflow files (deployment automation)
- ✅ README and documentation
- ✅ .gitignore and .terraform.lock.hcl

### What MUST Stay Private
- ❌ Service account JSON keys
- ❌ Terraform state files (`.tfstate`)
- ❌ Variable files with secrets (`.tfvars`)
- ❌ Any file with credentials or API keys

## Incident Response

### If Service Account Key is Leaked

1. **Immediately revoke the key** in GCP Console
2. **Create new service account** (don't reuse compromised one)
3. **Update GitHub Secret** with new key
4. **Review GCP audit logs** for unauthorized access
5. **Rotate any other potentially compromised credentials**

### If Terraform State Contains Sensitive Data

Current setup stores state locally (not committed). For teams:
- Use remote backend (GCS bucket with encryption)
- Enable state locking
- Restrict bucket access

## Monitoring

### Check for Unauthorized Access
- **GitHub Actions**: Monitor workflow runs in Actions tab
- **GCP Console**: Review audit logs regularly
  - https://console.cloud.google.com/logs?project=marine9007
- **Service Account Usage**: Check for unusual activity
  - IAM → Service Accounts → View Activity

### Alerts to Set Up
1. GCP Budget alerts (prevent surprise bills)
2. IAM policy change notifications
3. Unusual API usage patterns

## Questions?

If you discover a security issue:
1. **Do NOT** open a public issue
2. Contact repo owner directly: @marine9007

