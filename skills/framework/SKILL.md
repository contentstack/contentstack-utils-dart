---
name: framework
description: Use when touching pubspec/lockfile, analysis_options, CI security scans, or shared runtime deps (html, logger, path)
---

# Framework – Contentstack Utils (Dart)

Use this skill when changing project tooling, dependencies, or CI security configuration. This package has **no** HTTP client or retry layer (unlike full CDA SDKs); “framework” here means **Pub**, **analyzer/lint**, **CI**, and **shared libraries** used by `lib/`.

## When to use

- Bumping or adding dependencies in **`pubspec.yaml`** / **`pubspec.lock`**.
- Fixing or updating **`analysis_options.yaml`** (e.g. pedantic/lints includes).
- Changing **`.github/workflows/sca-scan.yml`** or other security-related CI.
- Refactoring use of **`package:html`**, **`package:logger`**, or **`package:path`** across helpers.

## Instructions

### Pub

- **Install:** `dart pub get`.
- **Lockfile:** Commit **`pubspec.lock`** for reproducible builds and OSV scanning.
- Before merging dep changes: run **`dart test`** and **`dart analyze .`**.

### Analysis and lint

- **`analysis_options.yaml`** must resolve included packages (e.g. pedantic/lints). Coordinate with the team before switching lint sets.
- **Runtime vs dev:** Keep **`dependencies`** minimal (`path`, `html`, `logger`, `lint`); **`dev_dependencies`** for `test`, `lints`.

### CI security

- **`.github/workflows/sca-scan.yml`:** `dart pub outdated`, OSV scanner on **`pubspec.lock`**. Review output on dependency PRs.
- **`.github/workflows/policy-scan.yml`:** **`SECURITY.md`** and **`LICENSE`** for public repos.

### Publishing

- **`.github/workflows/publish.yml`:** Publishes on **`v*.*.*`** tags. Do not publish from broken analyzer or untested dependency states.

## Key files

- **`pubspec.yaml`**, **`pubspec.lock`**, **`analysis_options.yaml`**
- **`.github/workflows/sca-scan.yml`**, **`.github/workflows/publish.yml`**

## References

- Project rules: `.cursor/rules/dart.mdc`, `.cursor/rules/code-review.mdc`
- CDA behavior (not deps): `skills/contentstack-utils/SKILL.md`
