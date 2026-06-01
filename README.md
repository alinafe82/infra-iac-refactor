# infra-iac-refactor

A small Terraform refactor that pulls naming, environment validation, and tagging conventions out of every service module and into one `foundation` module that callers consume.

The resources are deliberately minimal. The repo can be reviewed end-to-end without `terraform apply` ever touching a cloud account.

## Why centralize this

Three services that each define their own tag map will drift. One forgets `environment`. Another spells `managed_by` differently. A fourth ships a new tag and nobody propagates it. Centralizing the small things — naming prefix, environment whitelist, default tag set — removes the drift surface without locking callers into a heavyweight platform module.

The `foundation` module exposes two things and nothing else:

- `naming_prefix` (string like `platform-foundation-stage`)
- `common_tags` (map merged with caller-supplied overrides)

That is the smallest useful surface for the problem.

## What I would not centralize

- Network topology, IAM policies, KMS keys. Those are not "shared conventions"; they are real resources that need real review and per-service tuning.
- Provider versions. Pinning belongs to the consuming service so platform upgrades roll out one service at a time.
- Anything that requires the foundation to know about a specific cloud service. The foundation has no `aws_*` resources for a reason.

## Quickstart

```bash
terraform init -backend=false
terraform fmt -check -recursive
terraform validate
terraform test
```

CI runs the same four commands plus a nested-module validation pass.

## Module boundary

- `modules/foundation/variables.tf` enforces project-name regex and a closed set of environments (`dev`, `stage`, `prod`).
- `modules/foundation/outputs.tf` exposes `naming_prefix` and `common_tags`.
- `main.tf` is the consumer example. It calls `module.foundation` the way a real service module would.
- `.github/workflows/terraform.yml` runs the test suite on every push.

Design rationale lives in [docs/architecture.md](docs/architecture.md).

## Tests

`tests/foundation.tftest.hcl` covers:

- output stability: `naming_prefix` and `common_tags` match expected values for known inputs.
- invalid environment rejection (e.g., `env = "qa"`).

Next validation steps (not yet shipped):

- invalid project-name rejection at the root variable boundary.
- caller-tag merge semantics (caller can extend, but cannot override `project`, `environment`, `managed_by`).

## Adapter work left before this could provision real AWS

This repo deliberately stops short. To use it against a real account you would need:

- A provider block scoped to a region with backend state.
- A consumer module per service (e.g., `modules/example-service-a` and `modules/example-service-b`) that calls `foundation` and then declares the real resources.
- A policy-check pass (tflint, checkov, or sentinel) wired into CI.

The repo has none of those on purpose. The point is the convention layer, not the resource catalog.

## Operational notes

- [docs/runbook.md](docs/runbook.md)
- [docs/security-notes.md](docs/security-notes.md)
- [docs/production-readiness.md](docs/production-readiness.md)
- [docs/interview-notes.md](docs/interview-notes.md)
