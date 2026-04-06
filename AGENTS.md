# Contentstack Utils (Dart) – Agent Guide

This document is the main entry point for AI agents working in this repository.

## Project

- **Name:** Contentstack Utils for Dart (`contentstack_utils` on pub.dev)
- **Purpose:** Dart utilities to **render rich text and embedded entries** from Contentstack **Delivery JSON** (classic RTE, Supercharged RTE, and GraphQL-shaped SRTE). Used with **`package:contentstack`**; this package does **not** perform HTTP calls or manage API keys.
- **Repo:** [contentstack-utils-dart](https://github.com/contentstack/contentstack-utils-dart)

## Tech stack

- **Language:** Dart (see `environment.sdk` in `pubspec.yaml`)
- **Build:** Pub (`dart pub`)
- **Testing:** `package:test` (`dart test`)
- **Lint / analysis:** `analysis_options.yaml` (verify includes resolve with `dart analyze`)
- **Other:** `path`, `html`, `logger`, `lint` (runtime deps in `pubspec.yaml`)

## Main entry points

- **`Utils`** – `lib/contentstack_utils.dart`: `render`, `renderContent`, `jsonToHTML`; exports **`Metadata`**, **`StyleType`**.
- **`Option`** – `lib/src/model/Option.dart`: `renderOption`, `Option.entry`.
- **`GQL`** – `lib/src/GQL.dart`: `jsonToHTML` for GraphQL SRTE (import explicitly; not re-exported from barrel).
- **Paths:** `lib/` (package root + `lib/src/`), `test/` (`*_test.dart`), `example/example.dart`.

## Commands

- **Dependencies:** `dart pub get`
- **Analyze and format:** `dart analyze .` and `dart format .`
- **Tests:** `dart test`

Publishing (maintainers): tag-driven **`dart pub publish`** — see `.github/workflows/publish.yml`.

CI: branch rules (`.github/workflows/check-branch.yml`), SCA (`.github/workflows/sca-scan.yml`), policy (`.github/workflows/policy-scan.yml`).

## Rules and skills

- **`.cursor/rules/`** – Cursor rules for this repo:
  - **README.md** – Index of all rules.
  - **dev-workflow.md** – Development workflow (branches, tests, PRs).
  - **dart.mdc** – Applies to `**/*.dart`: Dart SDK, pub, analysis, imports.
  - **contentstack-utils.mdc** – Applies to `lib/**`: `Utils`, `GQL`, `Option`, RTE/embedded JSON, errors.
  - **testing.mdc** – Applies to `test/**`: `package:test`, fixtures, coverage.
  - **code-review.mdc** – Always applied: PR/review checklist.
- **`skills/`** – Reusable skill docs:
  - Use **contentstack-utils** when implementing or changing RTE rendering, `GQL`, `Option`, or `ErrorMessages`.
  - Use **testing** when adding or refactoring tests.
  - Use **code-review** when reviewing PRs or before opening one.
  - Use **framework** when changing `pubspec`/lockfile, analysis/lint setup, CI security scans, or shared runtime deps (`html`, `logger`).

Refer to `.cursor/rules/README.md` for when each rule applies and to `skills/README.md` for skill details.
