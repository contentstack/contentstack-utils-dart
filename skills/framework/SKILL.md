---
name: framework
description: Use when touching pubspec/lockfile, analysis_options, CI security workflows, or shared runtime deps (html, logger, path)
---

# Framework and tooling – Contentstack Utils (Dart)

## When to use

- Bumping or adding dependencies in **`pubspec.yaml`** / **`pubspec.lock`**.
- Changing **`analysis_options.yaml`** or lint includes.
- Editing **`.github/workflows/sca-scan.yml`**, **`.github/workflows/publish.yml`**, or policy-related CI.
- Refactoring shared library usage (**`package:html`**, **`package:logger`**, **`package:path`**) across **`lib/`**.

This package has **no** HTTP client, retries, or native modules — only Pub, analyzer, CI, and the runtime libraries listed in **`pubspec.yaml`**.

## Instructions

### Pub

- **Install:** **`dart pub get`**.
- **Lockfile:** Commit **`pubspec.lock`** for reproducible builds and OSV scanning.
- Before merging dep changes: **`dart test`** and **`dart analyze .`**.

### Analysis and lint

- **`analysis_options.yaml`** must resolve included packages; align **`lint`** / **`lints`** with the team before large policy changes.
- **Runtime deps:** `path`, `html`, `logger`, `lint` — keep minimal.
- **Dev:** `test`, `lints`.

### CI security

- **`.github/workflows/sca-scan.yml`:** **`dart pub outdated`**, OSV on **`pubspec.lock`**.
- **`.github/workflows/policy-scan.yml`:** **`SECURITY.md`**, **`LICENSE`** (public repos).

### Publishing

- **`.github/workflows/publish.yml`:** tag pattern **`v*.*.*`**, **`dart pub publish`** after dry-run.

## References

- **`skills/dart/SKILL.md`** — everyday Dart conventions
- **`skills/code-review/SKILL.md`** — dependency / security review
- **`skills/contentstack-utils/SKILL.md`** — API behavior (orthogonal to version bumps)
- **`AGENTS.md`** — workflow file pointers
