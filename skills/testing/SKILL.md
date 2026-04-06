---
name: testing
description: Use when writing or refactoring tests – dart test, *_test.dart, test/mock fixtures, coverage, offline-only
---

# Testing – Contentstack Utils (Dart)

Use this skill when adding or refactoring tests in this repository.

## When to use

- Writing new tests or changing existing **`test/*_test.dart`** files.
- Adding or updating JSON under **`test/mock/`**.
- Adjusting coverage workflow or **`test/.test_coverage.dart`**.

## Instructions

### Runner and layout

- **Command:** `dart test` from the repo root.
- **Framework:** **`package:test`** (`dev_dependency` in **`pubspec.yaml`**).
- **Files:** `*_test.dart` in **`test/`** (e.g. `utils_test.dart`, `gql_test.dart`).

### Fixtures

- Store JSON under **`test/mock/`** (e.g. `embedded_items.json`, `graphqlmock/`, `supercharged/`). Load with **`dart:io`** **`File`** and **`dart:convert`** as in **`test/utils_test.dart`**.
- **No credentials:** Tests are offline only; no `.env` stack keys for this package.

### Coverage

- Optional: `dart test --coverage=coverage`; align with **`coverage/`**, **`coverage_badge.svg`**, and any **`genhtml`** step your team uses.
- **`test/.test_coverage.dart`** — update if legacy aggregation is still required when adding suites.

### Conventions

- Assert **`Utils`**, **`GQL`**, **`Option`**, and **`Automate`** behavior against realistic fixture shapes.
- Keep tests deterministic (no network).

## References

- **`pubspec.yaml`** — `test` dev dependency
- Project rule: `.cursor/rules/testing.mdc`
