# Architecture

## Problem

Infrastructure repos often accumulate repeated naming, tagging, and environment defaults. That
duplication makes later platform changes slow because every service module must be updated by
hand.

## Intended User

The intended user is a platform engineer refactoring Terraform modules so teams can consume
shared conventions without copying boilerplate.

## Components

- Root module: represents a service or environment using the shared foundation.
- Foundation module: owns shared naming and tag inputs.
- Terraform CI: validates formatting and module structure.

## Data Flow

The root module passes `project`, `env`, and tags into `modules/foundation`. The module returns
a `naming_prefix` output that callers can use consistently.

## Design Choices

I kept the module small because the goal is to show the refactor boundary, not model a full
cloud platform. The module can grow once there are repeated conventions worth centralizing.

The provider is configured for validation without credentials so CI can run safely on pull
requests without cloud access.

## What Is Not Built

This repo does not provision production infrastructure. It does not include VPCs, IAM, logging,
or remote state.

## Extension Points

- Add service modules that consume `foundation`.
- Add provider aliases for multi-region examples.
- Add `terraform test` for module behavior.
- Add policy-as-code checks for real infrastructure rules.

## Operational Considerations

A production version should include remote state, state locking, a promotion workflow, and
environment-specific review gates.

## Testing Strategy

CI runs `terraform fmt` and `terraform validate`. If the module begins creating real resources,
the next step would be `terraform test` plus policy checks.
