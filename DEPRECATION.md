# Deprecation notice: Contentstack Dart Utils (pub.dev)

This page is for **developers using the Contentstack Dart Utils** package published on **pub.dev** as [`contentstack_utils`](https://pub.dev/packages/contentstack_utils).

## What this means for you

**We are deprecating this package as the recommended path for new Dart and Flutter work.** If you are **starting a new project**, use our **[Content Delivery API (CDA)](https://www.contentstack.com/docs/developers/apis/content-delivery-api/)** and implement rich text / JSON RTE handling in your app using current product documentation.

**If you already ship an app** that depends on `contentstack_utils`, you can **keep using it**. Your integration continues to work. Plan migration when it fits your release schedule—you do not have to change immediately.

The **[Contentstack Dart SDK](https://github.com/contentstack/contentstack-dart)** is deprecated on the same timeline; see that repository’s **DEPRECATION.md**.

## What to use for new projects

| | Link |
|---|------|
| **Content Delivery API** | [Content Delivery API documentation](https://www.contentstack.com/docs/developers/apis/content-delivery-api/) |

## Why we are making this change

We are focusing investment on **direct API usage** and **documented integration patterns** for Dart and Flutter. This repository will remain in **maintenance**: we may address critical or security issues where we can, but **we do not plan new features** in this package.

## Support for this package going forward

This repository will stay in **maintenance** as described above. Feature work and new capabilities should be built against the **Content Delivery API** and your application code.

If you need help choosing a migration path or timing, contact **[Contentstack support](https://www.contentstack.com/)** or your account team.
