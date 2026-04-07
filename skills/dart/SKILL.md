---
name: dart
description: Use when editing Dart sources — SDK constraints, lib layout, imports, analyzer, formatting, dependencies
---

# Dart – Contentstack Utils (Dart)

## When to use

- Editing any **`*.dart`** file under **`lib/`** or **`test/`**.
- Changing **`pubspec.yaml`** dependency lists (coordinate with **`skills/framework/SKILL.md`** for lockfile and CI impact).
- Fixing or discussing **`analysis_options.yaml`** behavior.

## Instructions

### Language and SDK

- Honor **`environment.sdk`** in **`pubspec.yaml`** (`>=2.12.0 <4.0.0`). Do not require a newer SDK in code without updating the constraint deliberately.

### Analyzer and formatting

- Lints are driven by **`analysis_options.yaml`** (includes `package:pedantic/analysis_options.yaml` today — ensure the resolved package exists or fix the include with the team).
- Run **`dart format .`** before PRs.

### Package layout and naming

- **Barrel:** **`lib/contentstack_utils.dart`**
- **Implementation:** **`lib/src/`** — `helper/`, `model/`, `embedded/`, `constants/`
- **Files:** `PascalCase.dart` under **`lib/src/`**; **`test/*_test.dart`** use snake_case.

### Imports

- Prefer **`package:contentstack_utils/...`** in library code.
- Tests may import the barrel plus **`package:contentstack_utils/src/...`** (e.g. **`Automate.dart`**) to exercise internals — follow existing tests.

### Dependencies

- **Runtime:** `path`, `html`, `logger`, `lint` — keep the package lean; no new packages without review.
- **Typing:** JSON is often **`Map`** / dynamic; improve safety incrementally and match patterns in **`lib/src/helper/Automate.dart`** and **`lib/src/model/Option.dart`**.

## References

- **`skills/contentstack-utils/SKILL.md`** — public API behavior
- **`skills/framework/SKILL.md`** — lockfile, CI, analyzer policy changes
- **`AGENTS.md`** — command quick reference
