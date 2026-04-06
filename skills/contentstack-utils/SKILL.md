---
name: contentstack-utils
description: Use when implementing or changing Utils, GQL, Option, RTE/embedded JSON, and ErrorMessages — alignment with package:contentstack
---

# Contentstack Utils API – Contentstack Utils (Dart)

## When to use

- Adding or changing **`Utils`**, **`GQL`**, **`Option`**, **`Metadata`**, **`StyleType`**, or **`Automate`** behavior.
- Defining how **`FormatException`** and **`ErrorMessages`** apply to invalid JSON or embedded input.
- Ensuring imports remain stable for **`package:contentstack`** consumers.

## Instructions

### Entry points

- **Barrel:** `package:contentstack_utils/contentstack_utils.dart` — **`Utils`**, exported **`Metadata`**, **`StyleType`**.
- **Option:** `package:contentstack_utils/src/model/Option.dart` — **`renderOption(Map, Metadata)`**, **`Option.entry(Map)`**.
- **GQL:** `package:contentstack_utils/src/GQL.dart` — **`GQL.jsonToHTML`**. Not re-exported from the barrel; import explicitly.

### Boundaries

- This package only transforms **fetched** entry JSON (`_embedded_items`, RTE HTML). **No HTTP** — stack credentials and delivery API calls belong in the [Contentstack Dart SDK](https://pub.dev/packages/contentstack).

### Public behavior

- **`Utils.render`**, **`Utils.renderContent`**, **`Utils.jsonToHTML`** — walk embedded items, resolve RTE paths, render via **`Option`**; invalid input throws **`FormatException`** with **`ErrorMessages`** text.
- **`GQL.jsonToHTML`** — GraphQL-shaped SRTE (`embedded_itemsConnection`, nested `json`).
- Centralize user-facing strings in **`lib/src/constants/ErrorMessages.dart`**.
- RTE parsing uses **`package:html`**; helpers may use **`package:logger`** — stay consistent with **`lib/src/helper/Automate.dart`**.

### Versioning and docs

- User-visible changes: update **`README.md`** and **`CHANGELOG.md`**; follow **`jsonToHTML`** naming in code (avoid README typos like `jsonToHtml`).

## References

- **`skills/dart/SKILL.md`** — layout and imports
- **`skills/testing/SKILL.md`** — tests for API changes
- [Contentstack documentation](https://www.contentstack.com/docs)
- [contentstack_utils on pub.dev](https://pub.dev/packages/contentstack_utils)
