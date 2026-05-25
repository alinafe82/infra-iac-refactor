# Runbook

## Run Locally

```bash
terraform init -backend=false
terraform fmt -check -recursive
terraform validate
terraform test
```

Validate the nested module directly:

```bash
cd modules/foundation
terraform init -backend=false
terraform fmt -check -recursive
terraform validate
terraform test
```

## Test

The current test layer is Terraform validation:

```bash
terraform fmt -check -recursive
terraform validate
```

## Common Failure Modes

- Terraform is not installed locally: install Terraform 1.5 or newer.
- Invalid `env`: use `dev`, `stage`, or `prod`.
- Invalid `project`: use lowercase letters, numbers, and hyphens, starting with a letter.
- Provider credential errors: make sure you are running `terraform init -backend=false`; this
  repo is meant to validate without cloud credentials.

## Troubleshooting

- Run `terraform fmt -recursive` if formatting fails.
- Validate the root and module separately to isolate failures.
- Keep provider and backend configuration credential-free for pull request validation.

## Safe Cleanup

Remove local Terraform files if needed:

```bash
rm -rf .terraform .terraform.lock.hcl modules/foundation/.terraform modules/foundation/.terraform.lock.hcl
```

Only remove these local generated files. Do not delete source `.tf` files.

## Known Limitations

The repo does not apply or provision infrastructure. It demonstrates the refactor boundary for
shared conventions.
