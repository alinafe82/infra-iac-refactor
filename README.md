# infra-iac-refactor
Small Terraform refactor example for shared infrastructure conventions.

This repo shows a minimal before/after shape for pulling repeated infrastructure conventions
into a shared `foundation` module. The resources are intentionally minimal so the repo can be
reviewed without provisioning cloud infrastructure.

## What It Solves

Repeated Terraform snippets make naming, tagging, and environment defaults drift across
services. This example centralizes those conventions behind a module and validates the result
in CI.

## Quickstart

```bash
terraform init -backend=false
terraform fmt -check -recursive
terraform validate
```

The GitHub Actions workflow runs the same validation for the root module and the nested module.

## Architecture Overview

- `main.tf` wires the root module to `modules/foundation`.
- `variables.tf` holds caller-facing inputs.
- `modules/foundation` owns shared naming, environment validation, and tagging conventions.
- `.github/workflows/terraform.yml` checks formatting and validation.

See [docs/architecture.md](docs/architecture.md) for design details.
See [docs/runbook.md](docs/runbook.md), [docs/security-notes.md](docs/security-notes.md),
and [docs/production-readiness.md](docs/production-readiness.md) for operational notes.

## Limitations

- This is an illustrative refactor, not a full AWS foundation.
- It does not create real networking, IAM, or logging resources.
- Terraform is not installed by the repo; CI installs it through `hashicorp/setup-terraform`.

## Future Improvements

- Add examples for two service modules consuming the same foundation module.
- Add `terraform test` when module behavior grows beyond simple outputs.
- Add policy checks if the repo starts modeling real resources.

## Interview Notes

See [docs/interview-notes.md](docs/interview-notes.md).
