# A Contentstack-Utils library for Dart developers

![Coverage](https://github.com/contentstack/contentstack-utils-dart/blob/master/coverage_badge.svg?sanitize=true)

## Contentstack Dart Utils SDK

Contentstack is a headless CMS with an API-first approach. It is a CMS that developers can use to build powerful cross-platform applications in their favorite languages. Build your application frontend, and Contentstack will take care of the rest. [Read More](https://www.contentstack.com/docs).

Given below is the detailed guide and helpful resources to get started with our Dart Utils SDK.

## Prerequisite

Latest Android Studio or IntelliJ IDEA or Visual Studio Code

- Setup and Installation

- We need to install dart

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
import 'package:contentstack_utils/src/helper/Metadata.dart';
import 'package:contentstack_utils/src/model/Option.dart';

class OptionDemo implements Option {
  @override
  String renderMark(String markType, String renderText) {
    // TODO: implement renderMark
    switch (markType) {
      case 'bold':
        return '<b>' + renderText + '</b>';
        break;
      default:
        return '';
    }
  }

  @override
  String renderNode(nodeType, Map node_obj, callback) {
    // TODO: implement renderNode
    switch (nodeType) {
      case 'paragraph':
        String children = callback.renderChildren(node_obj['children']);
        return "<p class='class-id'>" + children + '</p>';
        break;
      default:
        return '';
    }
  }

  @override
  String renderOption(Map obj, Metadata metadata) {
    // TODO: implement renderNode
    switch (metadata.getStyleType) {
      case 'block':
        return '<p>' + obj['title'] + '</p><span>' + obj['multi'] + '</span>';
        break;
      case 'inline':
        return '<p>' + obj['title'] + '</p><span>' + obj['line'] + '</span>';
        break;
      case 'link':
        return '<p>' + obj['title'] + '</p><span>' + obj['key'] + '</span>';
        break;
      case 'display':
        return '<p>' + obj['title'] + '</p><span>' + obj['multi'] + '</span>';
        break;
      default:
        return '';
    }
  }
}
 
```

## Using Contentstack Utils from Contentstack Dart SDK

### Fetch entry/entries including embedded using Contentstack SDK

```dart
    import 'package:contentstack/contentstack.dart' as contentstack;
    final stack = contentstack.Stack(apiKey, deliveryToken, environment);
    final entry = stack.contentType('contentTypeUid').entry(entryUid: 'entryUid');
    entry..includeEmbeddedItems();
    await entry.fetch().then((response) {
        const keyPath = [ "rich_text_editor", "global_rich_multiple.group.rich_text_editor"]
        final jsonObject = response['entry'];
        Utils.render(jsonObject, keyPath, Option);
    }).catchError((error) {
        print(error.message.toString());
    });
```

### Fetch multiple entries including embedded object and render RTE fields

```dart
    import 'package:contentstack/contentstack.dart' as contentstack;
    final stack = contentstack.Stack(apiKey, deliveryToken, environment);
    final query = stack.contentType('contentTypeUid').entry().query();
    await query.find().then((response) {
        var entries = response['entries'];
        const keyPath = ["rich_text_editor", "global_rich_multiple.group.rich_text_editor"]
        entries.forEach((entry){
            Utils.render(entry, keyPath, Option);
        })
    }).catchError((error) {
        print(error.message.toString());
    });
```

### Supercharged (SRTE)

```dart
    import 'package:contentstack/contentstack.dart' as contentstack;
    final stack = contentstack.Stack(apiKey, deliveryToken, environment);
    final query = stack.contentType('contentTypeUid').entry().query();
    await query.find().then((response) {
        var entries = response['entries'];
        const keyPath = ["rich_text_editor"]
        entries.forEach((entry){
            Utils.jsonToHtml(entry, keyPath, Option);
        })
    }).catchError((error) {
        print(error.message.toString());
    });
```

### GraphQl SRTE

```dart
    import 'package:contentstack/contentstack.dart' as contentstack;
    final stack = contentstack.Stack(apiKey, deliveryToken, environment);
    final query = stack.contentType('contentTypeUid').entry().query();
    await query.find().then((response) {
        var entries = response['entries'];
        const keyPath = ["rich_text_editor"]
        entries.forEach((entry){
            GQL.jsonToHtml(entry, keyPath, Option);
        })
    }).catchError((error) {
        print(error.message.toString());
    });
```

## Features and bugs

Please file feature requests and bugs at the [issue tracker][tracker].

[tracker]: http://example.com/issues/replaceme
