# Cursor Rules – Contentstack Utils (Dart)

This directory contains Cursor AI rules that apply when working in this repository. Rules provide persistent context so the AI follows project conventions and Contentstack Utils patterns.

## How rules are applied

- **File-specific rules** use the `globs` frontmatter: they apply when you open or edit files matching that pattern.
- **Always-on rules** use `alwaysApply: true`: they are included in every conversation in this project.

## Rule index

| File | Applies when | Purpose |
|------|--------------|---------|
| **dev-workflow.md** | (Reference only; no glob) | Core development workflow: branches, running tests, PR expectations. Read for process guidance. |
| **dart.mdc** | Editing any `**/*.dart` | Dart SDK constraint, package layout, `analysis_options.yaml`, imports, `pubspec` dependencies. |
| **contentstack-utils.mdc** | Editing `lib/**` | Utils patterns: `Utils` / `GQL` / `Option`, RTE and embedded JSON, `FormatException` / `ErrorMessages`, alignment with `package:contentstack`. |
| **testing.mdc** | Editing `test/**` | Testing patterns: `package:test`, `*_test.dart`, `test/mock/` fixtures, coverage, offline tests. |
| **code-review.mdc** | Always | PR/review checklist: API stability, error handling, backward compatibility, dependencies and security (e.g. SCA). |

## Related

- **AGENTS.md** (repo root) – Main entry point for AI agents: project overview, entry points, and pointers to rules and skills.
- **skills/** – Reusable skill docs (Contentstack Utils, testing, code review, framework) for deeper guidance on specific tasks.
