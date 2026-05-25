# Security Notes

## Threat Assumptions

- This repo validates Terraform structure without applying infrastructure.
- No cloud credentials are required for CI or local validation.
- The repo should not contain real account IDs, internal hostnames, or private tags.

## What It Protects Against

- Bad environment names through Terraform input validation.
- Bad project names through Terraform input validation.
- Accidental credential requirements in CI by using `terraform init -backend=false` and provider
  validation skips.
- Secret commits through repository secret scanning.

## What It Does Not Protect Against

- Misconfigured real cloud resources, because this repo does not create them.
- Terraform state exposure in a future backend.
- Overly broad IAM, networking, or logging rules if future resources are added.

## Safe Local Usage

```bash
terraform init -backend=false
terraform fmt -check -recursive
terraform validate
```

Do not run `terraform apply` from this repo unless real resources are intentionally added and
reviewed.

## Known Limitations

The AWS provider is present for shape and validation only. A production IaC repo would need
remote state, state locking, least-privilege credentials, environment gates, and policy checks.
