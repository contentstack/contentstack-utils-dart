---
name: dev-workflow
description: Use when branching, running CI-related commands, opening PRs, or deciding on TDD for this package
---

# Development workflow – Contentstack Utils (Dart)

## When to use

- Choosing a base branch or understanding merge policy into **`master`**.
- Running build, test, analyze, or format before a PR.
- Publishing (maintainers) or interpreting GitHub Actions workflows.
- Deciding whether to write tests first (TDD).

## Instructions

### Branches

- Use feature branches (e.g. `feat/...`, `fix/...`).
- Feature/fix PRs should target **`development`**. Release PRs are raised directly from **`development`** to **`master`**.

### Commands

- **Dependencies:** `dart pub get`
- **Tests:** `dart test`
- **Analyze:** `dart analyze .`
- **Format:** `dart format .`

Run **`dart analyze .`** and **`dart test`** before requesting review. There are **no** live-stack integration tests — only JSON fixtures under **`test/mock/`**.

### Pull requests

- Keep public API changes backward compatible or bump semver and update **`CHANGELOG.md`**.
- Dependency changes: consider **`.github/workflows/sca-scan.yml`** (OSV on **`pubspec.lock`**, **`dart pub outdated`**).

### Security and compliance (CI)

- **`.github/workflows/sca-scan.yml`** — dependency / OSV signals.
- **`.github/workflows/policy-scan.yml`** — **`SECURITY.md`** and **`LICENSE`** (public repos).

### Publishing (maintainers)

- **`.github/workflows/publish.yml`** — on **`release: types: [created]`** for tag **`v*`** (draft releases skipped), checks out the tag, then **`dart pub publish --dry-run`** and **`dart pub publish`**. **Manual** `workflow_dispatch` runs **dry-run only** (separate job).

### Optional TDD

If the team uses TDD: RED–GREEN–REFACTOR; fixture shapes in **`test/mock/`** should mirror Delivery / GQL payloads. Details: **`skills/testing/SKILL.md`**.

## References

- **`skills/testing/SKILL.md`** — test layout and fixtures
- **`skills/code-review/SKILL.md`** — PR checklist
- **`AGENTS.md`** — commands quick reference
