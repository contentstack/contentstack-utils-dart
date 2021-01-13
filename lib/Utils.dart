library contentstack_utils;

import 'dart:collection';

import 'package:html/dom.dart';
import 'package:html/parser.dart' show parse;

import 'package:contentstack_utils/src/callback/ContentCallback.dart';
import 'package:contentstack_utils/src/callback/OptionCallback.dart';
import 'package:contentstack_utils/src/helper/UtilityHelper.dart';

export 'src/embedded/StyleType.dart';
export 'src/helper/Metadata.dart';
export 'src/render/DefaultOption.dart';
export 'src/render/Option.dart';

class Utils {
  static void render(jsonObject,
      {List<String> rteKeys, OptionCallback optionCallback}) {
    var callback = ContentCallback();
    callback.contentObject((content) {
      print(content);
    });

    if (!UtilityHelper.isValidJson(jsonObject)) {
      FormatException('Invalid file type supplied');
    }

    if (jsonObject is List) {
      for (var entry in jsonObject) {
        render(entry, rteKeys: rteKeys, optionCallback: optionCallback);
      }
    } else if (jsonObject is LinkedHashMap) {
      if (jsonObject.containsKey('_embedded_items')) {
        if (rteKeys != null && rteKeys.isNotEmpty) {
          for (var path in rteKeys) {
            findContent(jsonObject, path, callback);
          }
        } else {
          LinkedHashMap embeddedKeys = jsonObject['_embedded_items'];
          rteKeys = embeddedKeys.keys.toList();
          embeddedKeys.keys.forEach((keyPath) {
            findContent(jsonObject, keyPath, callback);
          });
        }
      }
    } else {
      FormatException('Invalid file for embedded objects');
    }
  }

  static void findContent(
      LinkedHashMap jsonObj, String path, ContentCallback callback) {
    var arrayString = path.split('.');
    getContent(arrayString, jsonObj, callback);
  }

  static void getContent(List<String> arrayString, LinkedHashMap jsonObj,
      ContentCallback callback) {
    if (arrayString.isNotEmpty) {
      var key = arrayString[0];
      if (arrayString.length == 1) {
        var varContent = jsonObj[key];
        if (varContent is String || varContent is List) {
          // Do some calculations
          //TODO: need to confirm
          var result = callback.contentObject(varContent);
          //jsonObj[key] = result;
          //callback.contentObject(varContent));
        }
      } else {
        arrayString.remove(key);
        if (jsonObj[key] is Map<dynamic, dynamic>) {
          getContent(arrayString, jsonObj[key], callback);
        }
        if (jsonObj[key] is List<dynamic>) {
          var jsonArray = jsonObj[key];
          for (var item in jsonArray) {
            print(item);
            getContent(arrayString, item, callback);
          }
        }
      }
    }
  }

  static String renderContent(String rteStringify, LinkedHashMap embedObject,
      OptionCallback optionsCallback) {
    print(rteStringify);

    return 'samevalue';
  }

  static void getEmbeddedObjects(embeddedString) {
    var document = parse(embeddedString);
    var jnk = document.createElement('document');
    print(document.outerHtml);
  }
}
