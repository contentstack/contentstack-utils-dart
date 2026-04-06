---
name: code-review
description: Use when reviewing PRs or before opening a PR — API design, backward compatibility, dependencies, security, tests
---

# Code review – Contentstack Utils (Dart)

## When to use

- Reviewing a teammate’s PR or self-review before submit.
- Verifying API stability, errors, semver, SCA, and test coverage.

## Instructions

### API design and stability

- [ ] **Public API:** Changes to **`Utils`**, **`GQL`**, **`Option`**, or barrel exports are documented in **`README.md`** / **`CHANGELOG.md`** when user-facing.
- [ ] **Backward compatibility:** Breaking changes require explicit semver / changelog; **`GQL`** remains importable from **`package:contentstack_utils/src/GQL.dart`** for downstream SDKs.
- [ ] **Naming:** Matches existing methods (**`jsonToHTML`**, **`render`**, **`renderContent`**).

### Error handling

- [ ] Invalid JSON / embedded input throws **`FormatException`** with **`ErrorMessages`** (or documented behavior); no silent failures.
- [ ] Strings use **`ErrorMessages`** in **`lib/src/constants/ErrorMessages.dart`** where the library already centralizes them.

### Dependencies and security

- [ ] New or upgraded deps are justified; **`pubspec.lock`** updated intentionally.
- [ ] Consider **`.github/workflows/sca-scan.yml`** (OSV, **`dart pub outdated`**) on dependency PRs.

### Testing

- [ ] **`dart test`** passes; new behavior covered under **`test/`** with **`test/mock/`** where appropriate.
- [ ] No flaky or network-dependent tests.

### Severity (optional)

- **Blocker:** Breaking public API without approval, security regression, no tests for new code.
- **Major:** Inconsistent errors, missing changelog for user-visible change.
- **Minor:** Style, small doc nits.

## References

- **`skills/testing/SKILL.md`** — test expectations
- **`skills/contentstack-utils/SKILL.md`** — public API surface
- **`AGENTS.md`** — lint/test commands
