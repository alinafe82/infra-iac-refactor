# infra-iac-refactor
> Example Terraform refactor to DRY up modules and enforce conventions

This repo contains a small AWS sample showing how to:
- Extract common patterns into a `foundation` module
- Use opinionated variables and defaults
- Add `pre-commit` checks and `terraform fmt/validate`
- Document upgrade and migration steps

**Note:** This is illustrative — resources are minimal to avoid real costs.
