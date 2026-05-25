# ADR 0001: Extract Shared Terraform Conventions Into a Foundation Module

## Status

Accepted

## Context

Repeated Terraform conventions make platform-wide changes harder and increase drift between
service teams.

## Decision

The root module delegates shared naming and tag conventions to `modules/foundation`.

## Consequences

The example stays small and reviewable. The tradeoff is that it demonstrates the refactor
pattern rather than a complete cloud foundation.
