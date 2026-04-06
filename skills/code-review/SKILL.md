---
name: code-review
description: Use when reviewing PRs or before opening a PR – API design, backward compatibility, dependencies, security, and test quality
---

# Code Review – Contentstack Utils (Dart)

Use this skill when performing or preparing a pull request review for this package.

## When to use

- Reviewing someone else’s PR.
- Self-reviewing your own PR before submission.
- Checking that changes meet project standards (API, errors, compatibility, tests, security).

## Instructions

Work through the checklist below. Optionally tag items with severity: **Blocker**, **Major**, **Minor**.

### 1. API design and stability

- [ ] **Public API:** New or changed **`Utils`**, **`GQL`**, **`Option`**, or barrel exports are necessary and documented in **`README.md`** / **`CHANGELOG.md`** when user-facing.
- [ ] **Backward compatibility:** No breaking changes unless agreed (semver + changelog). **`GQL`** import path remains **`package:contentstack_utils/src/GQL.dart`** for downstream SDKs.
- [ ] **Naming:** Consistent with existing methods (**`jsonToHTML`**, **`render`**, **`renderContent`**).

**Severity:** Breaking public API without approval = Blocker. Missing changelog for user-visible change = Major.

### 2. Error handling and robustness

- [ ] **Errors:** Invalid input uses **`FormatException`** and **`ErrorMessages`** where the library already does.
- [ ] **Consistency:** No ad hoc error strings where **`ErrorMessages`** constants exist.

**Severity:** Silent failure on bad JSON = Blocker.

### 3. Dependencies and security

- [ ] **Dependencies:** Bumps justified; **`pubspec.lock`** updated intentionally.
- [ ] **SCA:** OSV / outdated findings considered on dependency PRs.

**Severity:** Known critical vulnerability introduced = Blocker.

### 4. Testing

- [ ] **Coverage:** New behavior has tests under **`test/`** with **`test/mock/`** fixtures as appropriate.
- [ ] **Quality:** Tests are readable and offline-only (no flakiness).

**Severity:** No tests for new behavior = Blocker.

### 5. Optional severity summary

- **Blocker:** Must fix before merge (e.g. breaking API without approval, security issue, no tests for new code).
- **Major:** Should fix (e.g. inconsistent errors, missing docs).
- **Minor:** Nice to fix (e.g. style, minor comments).

## References

- Project rule: `.cursor/rules/code-review.mdc`
- Testing skill: `skills/testing/SKILL.md`
