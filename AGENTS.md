# Contentstack Utils (Dart) – Agent guide

**Universal entry point** for contributors and AI agents. Detailed conventions live in **`skills/*/SKILL.md`**.

## What this repo is

| Field | Detail |
|-------|--------|
| **Name:** | [contentstack-utils-dart](https://github.com/contentstack/contentstack-utils-dart) — pub package **`contentstack_utils`** |
| **Purpose:** | Dart utilities to render rich text and embedded entries from Contentstack **Delivery JSON** (classic RTE, Supercharged RTE, and GraphQL-shaped SRTE). Typically used with **`package:contentstack`**. |
| **Out of scope (if any):** | **No HTTP client** — no stack calls, API keys, delivery tokens, or retries. Network and auth belong in the [Contentstack Dart SDK](https://pub.dev/packages/contentstack). |

## Tech stack (at a glance)

| Area | Details |
|------|---------|
| **Language** | Dart — `environment.sdk` in `pubspec.yaml` (`>=2.12.0 <4.0.0`) |
| **Build** | Pub — `pubspec.yaml`, `pubspec.lock` |
| **Tests** | `package:test` — `dart test`; files `test/*_test.dart` |
| **Lint / coverage** | `analysis_options.yaml`; coverage under `coverage/` / `lcov.info` when generated |
| **Other** | Runtime deps: `path`, `html`, `logger`, `lint` (see `pubspec.yaml`) |

## Commands (quick reference)

| Command type | Command |
|--------------|---------|
| **Build** | `dart pub get` |
| **Test** | `dart test` |
| **Lint** | `dart analyze .` and `dart format .` |

**CI:** feature/fix PRs target `development`, release PRs target `master` from `development`; SCA — `.github/workflows/sca-scan.yml`; publish on GitHub **Release** (`release: created`, tag `v*`) via `.github/workflows/publish.yml`; manual **workflow_dispatch** runs dry-run only; back-merge automation — `.github/workflows/back-merge-pr.yml`.

## Where the documentation lives: skills

| Skill | Path | What it covers |
|-------|------|----------------|
| **Development workflow** | `skills/dev-workflow/SKILL.md` | Branches, CI, commands, PR expectations, optional TDD |
| **Contentstack Utils API** | `skills/contentstack-utils/SKILL.md` | `Utils`, `GQL`, `Option`, RTE/embedded JSON, errors, boundaries with `package:contentstack` |
| **Dart** | `skills/dart/SKILL.md` | Dart SDK, `lib/` layout, imports, analyzer, naming |
| **Testing** | `skills/testing/SKILL.md` | `package:test`, `test/mock/`, coverage, offline-only tests |
| **Code review** | `skills/code-review/SKILL.md` | PR checklist, Blocker / Major / Minor |
| **Framework / tooling** | `skills/framework/SKILL.md` | `pubspec`, lockfile, `analysis_options.yaml`, CI security, shared deps (`html`, `logger`) |

An index with “when to use” hints is in `skills/README.md`.

## Using Cursor (optional)

If you use **Cursor**, `.cursor/rules/README.md` only points to **`AGENTS.md`** — same docs as everyone else.
