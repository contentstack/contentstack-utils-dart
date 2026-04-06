---
name: testing
description: Use when writing or refactoring tests — dart test, *_test.dart, test/mock fixtures, coverage, offline-only
---

# Testing – Contentstack Utils (Dart)

## When to use

- Adding or changing files under **`test/`**.
- Adding JSON fixtures or updating **`test/.test_coverage.dart`**.
- Generating or interpreting coverage output.

## Instructions

### Runner and layout

- **Command:** **`dart test`** from the repo root.
- **Framework:** **`package:test`** (`dev_dependency` in **`pubspec.yaml`**).
- **Files:** **`test/*_test.dart`** (e.g. `utils_test.dart`, `gql_test.dart`, `option_test.dart`).

### Fixtures and credentials

- JSON lives under **`test/mock/`** (`embedded_items.json`, `graphqlmock/`, `supercharged/`, etc.).
- Load with **`dart:io`** **`File`** and **`dart:convert`** as existing tests do.
- **No API keys or network** — tests are offline and deterministic.

### Coverage

- Optional: **`dart test --coverage=coverage`**; artifacts may include **`coverage/`**, **`coverage/lcov.info`**, **`coverage_badge.svg`**.
- **`test/.test_coverage.dart`** aggregates suites for legacy **`test_coverage`** workflows — update imports when adding suites if still used.

### What to assert

- **`Utils`**, **`GQL`**, **`Option`**, **`Automate.isValidJson`**, and shapes that match Delivery / GQL payloads.

## References

- **`skills/contentstack-utils/SKILL.md`** — behavior under test
- **`skills/dev-workflow/SKILL.md`** — when to run tests in the workflow
- **`AGENTS.md`** — `dart test` quick reference
