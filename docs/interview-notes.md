# Interview Notes

## 60-Second Explanation

This is a small Terraform repo showing how I would start refactoring repeated infrastructure
conventions into a shared module. It centralizes naming and tags, keeps validation credentialless
for CI, and avoids creating real cloud resources.

## Decisions I Can Defend

- Keep the module small until there is real duplication to remove.
- Run `terraform fmt` and `terraform validate` in CI before adding heavier tooling.
- Avoid cloud credentials in pull-request validation.

## Tradeoffs

The repo is intentionally narrow. It demonstrates the refactor pattern, but it is not a full
landing zone or production AWS foundation.

## Fixes Made During Portfolio Hardening

- Formatted Terraform files.
- Added `.gitignore` for Terraform state and local artifacts.
- Added architecture notes, ADR, and interview notes.

## Likely Questions

**Why not build a larger module?**
Large shared modules become hard to change. I would grow this only around repeated conventions
that multiple service modules actually need.

**What would you add for production?**
Remote state, state locking, policy checks, environment promotion, and module tests.

**What does this show for Engineering Productivity?**
It shows how to reduce copy/paste infrastructure work while keeping CI validation simple and
safe for contributors.
