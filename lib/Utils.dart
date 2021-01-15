library contentstack_utils;

import 'dart:collection';

import 'package:contentstack_utils/src/model/Option.dart';
import 'package:html/parser.dart' show parse;
import 'package:html/parser.dart';

import 'package:contentstack_utils/src/helper/Metadata.dart';
import 'package:contentstack_utils/src/helper/UtilityHelper.dart';

export 'src/embedded/StyleType.dart';
export 'src/helper/Metadata.dart';

class Utils {
  static void render(jsonObject, List<String> rteKeys, Option option) {
    if (!UtilityHelper.isValidJson(jsonObject)) {
      FormatException('Invalid file, Can\'t process the json file');
    }

    // Case: when list of Maps provided
    if (jsonObject is List) {
      for (var entry in jsonObject) {
        render(entry, rteKeys, option);
      }
    }
    // Case: when Map provided
    else if (jsonObject is Map) {
      if (jsonObject.containsKey('_embedded_items')) {
        if (rteKeys != null && rteKeys.isNotEmpty) {
          for (var path in rteKeys) {
            _findContent(jsonObject, path, (rteContent) {
              return renderContent(rteContent, jsonObject, option);
            });
          }
        } else {
          LinkedHashMap embeddedKeys = jsonObject['_embedded_items'];
          rteKeys = embeddedKeys.keys.toList();
          embeddedKeys.keys.forEach((keyPath) {
            _findContent(jsonObject, keyPath, (rteContent) {
              return renderContent(rteContent, jsonObject, option);
            });
          });
        }
      }
    } else {
      FormatException('Invalid file for embedded objects');
    }
  }

  static void _findContent(
      LinkedHashMap jsonObj, String path, Function(String) callback) {
    var arrayString = path.split('.');
    _getContent(arrayString, jsonObj, callback);
  }

  static void _getContent(
      List<String> arrayString, Map jsonObj, Function(String) callback) {
    if (arrayString.isNotEmpty) {
      var key = arrayString[0];
      if (arrayString.length == 1) {
        var varContent = jsonObj[key];
        if (varContent is String || varContent is List) {
          if (callback != null) {
            jsonObj[key] = callback(varContent);
          }
        }
      } else {
        arrayString.remove(key);
        if (jsonObj[key] is Map<dynamic, dynamic>) {
          _getContent(arrayString, jsonObj[key], callback);
        }
        if (jsonObj[key] is List<dynamic>) {
          var jsonArray = jsonObj[key];
          for (var item in jsonArray) {
            _getContent(arrayString, item, callback);
          }
        }
      }
    }
  }

//invoke

  static Object renderContent(rteString, Map embedObject, Option option) {
    if (rteString is String) {
      var available = embedObject.containsKey('_embedded_items');
      if (available) {
        var jsonArray = embedObject['_embedded_items'];
        _getEmbeddedItems(rteString, (metadata) {
          var filteredContent = _findEmbeddedItems(jsonArray, metadata);
          if (filteredContent != null) {
            var stringData = option.renderOption(filteredContent, metadata);
            rteString = rteString.replaceAll(metadata.outerHTML, stringData);
          }
        });
      }
      return rteString;
    } else if (rteString is List<String>) {
      var storeRTE = [];
      rteString.forEach((element) {
        var rte = renderContent(element, embedObject, option);
        storeRTE.add(rte);
      });

      return storeRTE;
    }
    return rteString;
  }

  static Map _findEmbeddedItems(Map jsonObject, Metadata metadata) {
    var keys = jsonObject.keys;
    for (var item in keys) {
      List jsonArray = jsonObject[item];
      var filteredContent = jsonArray
          .firstWhere((element) => element['uid'] == metadata.getItemUid);
      return filteredContent;
    }

    return null;
  }

  static void _getEmbeddedItems(stringHtml, Function(Metadata) callback) {
    final document = parse(stringHtml);
    var containerAsset = document.getElementsByClassName('embedded-asset');
    var containerEntry = document.getElementsByClassName('embedded-entry');
    if (containerAsset.isNotEmpty) {
      containerAsset.forEach((element) {
        callback(Metadata.element(element));
      });
    }
    if (containerEntry.isNotEmpty) {
      containerEntry.forEach((element) {
        callback(Metadata.element(element));
      });
    }
  }
}
