# A Contentstack-Utils library for Dart developers

![Coverage](https://raw.github.com/contentstack/contentstack-utils-python/master/coverage_badge.svg?sanitize=true)

## Contentstack Dart Utils SDK

Contentstack is a headless CMS with an API-first approach. It is a CMS that developers can use to build powerful cross-platform applications in their favorite languages. Build your application frontend, and Contentstack will take care of the rest. [Read More](https://www.contentstack.com/docs).

Given below is the detailed guide and helpful resources to get started with our Dart Utils SDK.

## Prerequisite

Latest Android Studio or IntelliJ IDEA or Visual Studio Code

- Setup and Installation

- We need to install Dart

## Dependency

Add the following to your pom.xml file:

```dart
    contentstack-util: any
```

Note: If you are using Contentstack Dart SDK we have already imported contentstack-utils into it.

```dart
    contentstack: any
```

## Usage

Create Render Option:
To render Embedded objects within RTE create renderOption as follows:

```dart
Utils.renderContents(rteArray, localJsonObj, (embeddedObject, metadata) -> {
    
    switch (metadata.getStyleType()) {
        case BLOCK:
           String title = embeddedObject.getString("title");
           String multi_line = embeddedObject.getString("multi_line");
           return "<p>" + title + "</p><span>" + multi_line + "</span>";

        case INLINE:
           String titleInline = embeddedObject.getString("title");
           String mlInline = embeddedObject.getString("multi_line");
           return "<p>" + titleInline + "</p><span>" + mlInline + "</span>";

        case LINKED:
           String titleLinked = embeddedObject.getString("title");
           String mlLinked = embeddedObject.getString("multi_line");
           return "<p>" + titleLinked + "</p><span>" + mlLinked + "</span>";
       
        case DISPLAY:
           String titleDiplayable = embeddedObject.getString("title");
           String mlDiplayable = embeddedObject.getString("multi_line");
           return "<p>" + titleDiplayable + "</p><span>" + mlDiplayable + "</span>";

       default:
           return null;
   }
});
```

## Using Contentstack Utils from Contentstack Dart SDK

**Fetch entry/entries including embedded using Contentstack SDK:**

```dart
    import 'package:contentstack/contentstack.dart' as contentstack;
    
    final stack = contentstack.Stack(apiKey, deliveryToken, environment);
    final entry = stack.contentType('contentTypeUid').entry(entryUid: 'entryUid');
    entry..includeEmbeddedItems();
    await entry.fetch().then((response) {
        print(response.toString());
    }).catchError((error) {
        print(error.message.toString());
    });
```

**Fetch multiple entries including embedded object and render RTE fields**

```dart
    import 'package:contentstack/contentstack.dart' as contentstack;

    final stack = contentstack.Stack(apiKey, deliveryToken, environment);
    final query = stack.contentType('contentTypeUid').entry().query();
    await query.find().then((response) {
        print(response.toString());
    }).catchError((error) {
        print(error.message.toString());
    });
```

Fetch entry/entries and Render RTE using GraphQL and ‘contentstack utils’ SDK

**GraphQL specification is not yet finalized.**

## Features and bugs

Please file feature requests and bugs at the [issue tracker][tracker].

[tracker]: http://example.com/issues/replaceme
