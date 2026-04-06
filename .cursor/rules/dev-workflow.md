# Development Workflow – Contentstack Utils (Dart)

Use this as the standard workflow when contributing to the Dart Utils package.

## Branches

- Use feature branches for changes (e.g. `feat/...`, `fix/...`).
- **`.github/workflows/check-branch.yml`** restricts merges into **`master`**: the head branch must be **`staging`** unless policy changes. Open PRs against **`staging`** per team norms.

## Running tests

- **All tests:** `dart test`
- **Analyze:** `dart analyze .`
- **Format:** `dart format .`

Run tests and analyze before opening a PR. This package has **no** integration tests against a live stack—tests use JSON under **`test/mock/`** only.

## Pull requests

- Ensure **`dart analyze .`** and **`dart test`** pass.
- Follow the **code-review** rule (see `.cursor/rules/code-review.mdc`) for the PR checklist.
- Keep changes backward-compatible for public API; call out breaking changes clearly with semver and **`CHANGELOG.md`**.

## Security and compliance (CI)

- **`.github/workflows/sca-scan.yml`:** `dart pub outdated`, OSV on **`pubspec.lock`**.
- **`.github/workflows/policy-scan.yml`:** **`SECURITY.md`** and **`LICENSE`** (public repos).

## Publishing (maintainers)

- Tag-driven: **`.github/workflows/publish.yml`** on `v*.*.*` tags via **`dart pub publish`**.

## Optional: TDD

If the team uses TDD, follow RED–GREEN–REFACTOR when adding behavior: write a failing test first, then implement, then refactor. The **testing** rule and **`skills/testing`** skill describe test layout and fixtures.
