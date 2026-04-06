# Skills – Contentstack Utils (Dart)

This directory contains **skills**: reusable guidance for AI agents (and developers) on specific tasks. Each skill is a folder with a `SKILL.md` file.

## When to use which skill

| Skill | Use when |
|-------|----------|
| **contentstack-utils** | Implementing or changing RTE rendering, embedded items, Supercharged or GQL SRTE, `Utils` / `GQL` / `Option`, `FormatException` / `ErrorMessages`, alignment with `package:contentstack`. |
| **testing** | Writing or refactoring tests: `dart test`, `*_test.dart`, `test/mock/` fixtures, coverage, offline-only tests. |
| **code-review** | Reviewing a PR or preparing your own: API design, backward compatibility, dependencies/security, test coverage. |
| **framework** | Touching `pubspec.yaml` / `pubspec.lock`, `analysis_options.yaml`, CI security workflows (OSV, outdated), or shared implementation deps (`html`, `logger`, `path`). |

## How agents should use skills

- **contentstack-utils:** Apply when editing `lib/**` or public API behavior. Follow `Utils` / `GQL` / `Option` contracts and existing error patterns.
- **testing:** Apply when creating or modifying tests under `test/`. Use `test/mock/` JSON and match existing test style.
- **code-review:** Apply when performing or simulating a PR review. Go through the checklist (API stability, errors, compatibility, dependencies, tests) and optional severity levels.
- **framework:** Apply when changing dependencies, analyzer config, or CI security steps. Keep the package lean and SCA-friendly.

Each skill’s `SKILL.md` contains more detailed instructions and references.
