---
name: contentstack-utils
description: Use when implementing or changing Utils, GQL, Option, RTE/embedded JSON, and ErrorMessages – alignment with package:contentstack
---

# Contentstack Utils (Dart) – Implementation

Use this skill when implementing or changing rich-text and embedded-item behavior in this package.

## When to use

- Adding or modifying **`Utils`**, **`GQL`**, **`Option`**, **`Metadata`**, **`StyleType`**, or **`Automate`** behavior.
- Changing how **`FormatException`** or **`ErrorMessages`** are used for invalid JSON or embedded input.
- Updating imports or public surface consumed by **`package:contentstack`**.

## Instructions

### Entry points

- **Barrel:** `package:contentstack_utils/contentstack_utils.dart` — **`Utils`**, exported **`Metadata`**, **`StyleType`**.
- **Option:** `package:contentstack_utils/src/model/Option.dart` — **`renderOption(Map, Metadata)`**, **`Option.entry(Map)`**.
- **GQL:** `package:contentstack_utils/src/GQL.dart` — **`GQL.jsonToHTML`**. Not re-exported from the barrel.

### Behavior

- **Delivery JSON only:** This package transforms fetched entry JSON (`_embedded_items`, RTE HTML). **No HTTP** — stack, API key, and delivery token belong in the [Contentstack Dart SDK](https://pub.dev/packages/contentstack).
- **Errors:** Throw **`FormatException`** with **`ErrorMessages`** where the codebase already does; keep messages maintainable via **`lib/src/constants/ErrorMessages.dart`**.
- **Parsing:** RTE HTML uses **`package:html`**; logging uses **`package:logger`** in helpers — stay consistent with **`lib/src/helper/Automate.dart`**.

### Official docs

- Product: [Contentstack documentation](https://www.contentstack.com/docs).
- Package: [contentstack_utils on pub.dev](https://pub.dev/packages/contentstack_utils).

## Key files

- **API:** `lib/contentstack_utils.dart`, `lib/src/GQL.dart`, `lib/src/model/Option.dart`
- **Helpers:** `lib/src/helper/Automate.dart`, `lib/src/model/NodeToHtml.dart`
- **Errors:** `lib/src/constants/ErrorMessages.dart`

## References

- Project rules: `.cursor/rules/contentstack-utils.mdc`, `.cursor/rules/dart.mdc`
