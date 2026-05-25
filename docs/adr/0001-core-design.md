# ADR 0001: Centralize Shared Terraform Conventions In A Small Module

## Context

Terraform repos often duplicate naming, tags, and environment conventions. The duplication is
easy to create and expensive to change later.

## Decision

Use a small `foundation` module to own shared naming and common tags, and keep the root module
as a consumer example.

## Alternatives Considered

- Leave conventions duplicated in the root module.
- Create a large foundation module with VPC, IAM, logging, and remote state.
- Move everything into a private module registry.

## Why This Design Was Selected

I chose this design because the repo is meant to show the refactor boundary. A small module is
enough to demonstrate validation and reuse without pretending to be a complete platform.

## Tradeoffs

The tradeoff is that the module is intentionally modest. It gives a clean structure but does
not prove behavior for real resources.

## Consequences

- CI can validate the code without cloud credentials.
- Shared conventions have one home.
- Future resource modules can consume the same naming and tag outputs.

## What Would Change At Larger Scale

At larger scale, I would add remote state, state locking, environment promotion, policy checks,
and module tests. I would add real resources only when there are repeated patterns worth
centralizing.
