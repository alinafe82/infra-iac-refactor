# Linting and Testing Standards

These standards define the checks expected before a pull request is marked ready. Run the sections for the
languages touched by the change.

## Required Gates

- Start from the default branch and keep the PR focused on one reviewable change.
- Run `git diff --check` before committing.
- Run `repowave scan .` when `repowave.toml` is present.
- Run every applicable language command below. If a command needs credentials, a live service, or unavailable
  platform tooling, state that in the PR and run the closest local gate.
- Add or update tests for behavior changes. Documentation-only changes still need the diff and repository gates.

## Documentation and IaC Examples

- Keep examples executable or explicitly mark them as illustrative.
- Validate any Terraform, CloudFormation, Kubernetes, or shell snippets with the native formatter and validator
  when such files are added.
- Prefer `terraform fmt -check`, `terraform validate`, `cfn-lint`, or `kubectl --dry-run=client` for future IaC
  files, depending on the file type.
- Do not publish fake deployment claims or incomplete infrastructure.

## Current Command Map

- Diff gate: `git diff --check`.
- Repository readiness: `repowave scan .`.
- Markdown review: verify command examples, links, and file paths changed in the PR.
