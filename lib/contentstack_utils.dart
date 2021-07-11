library contentstack_utils;

import 'package:contentstack_utils/src/helper/Metadata.dart';
import 'package:contentstack_utils/src/helper/UtilityHelper.dart';
import 'package:contentstack_utils/src/model/NodeToHtml.dart';
import 'package:contentstack_utils/src/model/Option.dart';
import 'package:html/parser.dart' show parse;
import 'package:logger/logger.dart';

export 'src/embedded/StyleType.dart';
export 'src/helper/Metadata.dart';

var logger = Logger(printer: PrettyPrinter());

class Utils {
  static void render(jsonObject, List<String> rteKeys, Option option) {
    if (!UtilHelper.isValidJson(jsonObject)) {
      throw FormatException('Invalid file, Can\'t process the json file');
    }

    if (jsonObject is List) {
      for (var entry in jsonObject) {
        render(entry, rteKeys, option);
      }
    } else if (jsonObject is Map<String, Object>) {
      if (jsonObject.containsKey('_embedded_items')) {
        if (rteKeys.isNotEmpty) {
          for (var path in rteKeys) {
            __find_embed_keys(jsonObject, path, (rteContent) {
              return renderContent(rteContent, jsonObject, option);
            });
          }
        } else {
          Map<String, Object> embeddedKeys = jsonObject['_embedded_items'];
          rteKeys = embeddedKeys.keys.toList();
          embeddedKeys.keys.forEach((keyPath) {
            __find_embed_keys(jsonObject, keyPath, (rteContent) {
              return renderContent(rteContent, jsonObject, option);
            });
          });
        }
      }
    } else {
      FormatException('Invalid file for embedded objects');
    }
  }

  static void __find_embed_keys(
      Map jsonObj, String path, Function(Object) callback) {
    var keys = path.split('.');
    _getContent(keys, jsonObj, callback);
  }

  static void _getContent(
      List<String> availableKeys, Map entry, Function(Object) callback) {
    if (availableKeys.isNotEmpty) {
      var key = availableKeys[0];
      if (availableKeys.length == 1) {
        var varContent = entry[key];
        if (varContent is String || varContent is List || varContent is Map) {
          if (callback != null) {
            entry[key] = callback(varContent);
          }
        }
      } else {
        availableKeys.remove(key);
        if (entry[key] is Map<dynamic, dynamic>) {
          _getContent(availableKeys, entry[key], callback);
        }
        if (entry[key] is List<dynamic>) {
          var jsonArray = entry[key];
          for (var item in jsonArray) {
            _getContent(availableKeys, item, callback);
          }
        }
      }
    }
  }

  static Object renderContent(rteString, Map embedObject, Option option) async {
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

  //{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}//
  //                   [SUPERCHARGED RTE]                         //
  //}}}}{{}{}{{{{{{{{{{{{{{{}}}}}}}}}}}}}}}}{{{{{{{{{{{}}}}}}}}}}}//

  static void jsonToHTML(items, List<String> key_path, Option option) {
    if (!UtilHelper.isValidJson(items)) {
      throw FormatException('Invalid file, Can\'t process the json file');
    }

    if (items is List) {
      for (var entry in items) {
        return jsonToHTML(entry, key_path, option);
      }
    }
    if (items is Map && key_path.isNotEmpty) {
      //var _callback = Utils._enumerateContent;
      for (var path in key_path) {
        __find_embed_keys(items, path, (rteContent) {
          return _enumerateContent(rteContent, items, option);
        });
      }
    }
  }

  static Object _enumerateContent(content, entry, option) {
    if (content is List) {
      var arrayContent = [];
      for (var item in content) {
        var result = Utils._enumerateContent(item, entry, option);
        arrayContent.add(result);
      }
      return arrayContent;
    }

    if (content is Map) {
      if (content.containsKey('type') && content.containsKey('children')) {
        if (content['type'] == 'doc') {
          return Utils._rawProcessing(content['children'], entry, option);
        }
      }
    }
    return '';
  }

  static String _rawProcessing(children, entry, option) {
    var array_container = [];
    for (var item in children) {
      if (item is Map) {
        array_container.add(Utils._extractKey(item, entry, option));
      }
    }
    return array_container.join('');
  }

  static String _extractKey(Map item, Map entry, Option option) {
    if (!item.containsKey('type') && item.containsKey('text')) {
      return NodeToHtml.textNodeToHtml(item, option);
    } else if (item.containsKey('type')) {
      var nodeStyle = item['type'];
      if (nodeStyle == 'reference') {
        var metadata = Utils._returnMetadata(item, nodeStyle);
        if (entry.containsKey('_embedded_items')) {
          var keys = entry['_embedded_items'].keys();
          for (var key in keys) {
            var itemsArray = entry['_embedded_items'][key];
            var content = Utils._findEmbeddedEntry(itemsArray, metadata);
            return Utils._getStringOption(option, metadata, content);
          }
        }
      } else {
        String call(children) {
          return Utils._rawProcessing(children, entry, option);
        }

        return option.renderNode(nodeStyle, item, call);
      }
    }
    return '';
  }

  static Object _findEmbeddedEntry(List jsonList, Metadata metadata) {
    for (var obj in jsonList) {
      if (obj['uid'] == metadata.getItemUid) {
        return obj;
      }
    }
    return null;
  }

  static String _getStringOption(
      Option option, Metadata metadata, Map content) {
    var stringOption = option.renderOption(content, metadata);
    if (stringOption == null || stringOption.isEmpty) {
      stringOption = option.renderOption(content, metadata);
    }
    return stringOption;
  }

  static Metadata _returnMetadata(Map item, nodeStyle) {
    Map attr = item['attrs'];
    var text = Utils._getChildText(item);
    var style = attr['display-type'];
    if (attr['type'] == 'asset') {
      return Metadata(
          text: text,
          itemType: nodeStyle,
          itemUid: attr['asset-uid'],
          contentTypeUid: 'sys-asset',
          styleType: style);
    } else {
      return Metadata(
          text: text,
          itemType: nodeStyle,
          itemUid: attr['entry-uid'],
          contentTypeUid: 'content-type-uid',
          styleType: style);
    }
  }

  static String _getChildText(Map item) {
    var text = '';
    if (item.containsKey('children')) {
      var children = item['children'];
      for (Map child in children) {
        if (child.containsKey(text)) {
          text = child['text'];
        }
      }
    }
    return text;
  }
}
