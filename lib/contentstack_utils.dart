library contentstack_utils;

import 'package:contentstack_utils/src/helper/Metadata.dart';
import 'package:contentstack_utils/src/helper/Automate.dart';
import 'package:contentstack_utils/src/model/Option.dart';
import 'package:html/parser.dart' show parse;

export 'src/embedded/StyleType.dart';
export 'src/helper/Metadata.dart';

class Utils {
  static void render(jsonObject, List<String> rteKeys, Option option) {
    if (!Automate.isValidJson(jsonObject)) {
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
            Automate.find_embed_keys(jsonObject, path, (rteContent) {
              return renderContent(rteContent, jsonObject, option);
            });
          }
        } else {
          Map<String, Object> embeddedKeys = jsonObject['_embedded_items'];
          rteKeys = embeddedKeys.keys.toList();
          embeddedKeys.keys.forEach((keyPath) {
            Automate.find_embed_keys(jsonObject, keyPath, (rteContent) {
              return renderContent(rteContent, jsonObject, option);
            });
          });
        }
      }
    } else {
      FormatException('Invalid file for embedded objects');
    }
  }

  // static void _getContent(
  //     List<String> availableKeys, Map entry, Function(Object) callback) {
  //   if (availableKeys.isNotEmpty) {
  //     var key = availableKeys[0];
  //     if (availableKeys.length == 1) {
  //       var varContent = entry[key];
  //       if (varContent is String || varContent is List || varContent is Map) {
  //         if (callback != null) {
  //           entry[key] = callback(varContent);
  //         }
  //       }
  //     } else {
  //       availableKeys.remove(key);
  //       if (entry[key] is Map<dynamic, dynamic>) {
  //         _getContent(availableKeys, entry[key], callback);
  //       }
  //       if (entry[key] is List<dynamic>) {
  //         var jsonArray = entry[key];
  //         for (var item in jsonArray) {
  //           _getContent(availableKeys, item, callback);
  //         }
  //       }
  //     }
  //   }
  // }

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
    if (!Automate.isValidJson(items)) {
      throw FormatException('Invalid file, Can\'t process the json file');
    }

    if (items is List) {
      for (var entry in items) {
        return jsonToHTML(entry, key_path, option);
      }
    }
    if (items is Map && key_path.isNotEmpty) {
      for (var path in key_path) {
        Automate.find_embed_keys(items, path, (rteContent) {
          return Automate.enumerateContent(rteContent, items, option);
        });
      }
    }
  }

  // static String _extractKey(Map item, Map entry, Option option) {
  //   if (!item.containsKey('type') && item.containsKey('text')) {
  //     return NodeToHtml.textNodeToHtml(item, option);
  //   } else if (item.containsKey('type')) {
  //     var nodeStyle = item['type'];
  //     if (nodeStyle == 'reference') {
  //       var metadata = Automate.returnMetadata(item, nodeStyle);
  //       if (entry.containsKey('_embedded_items')) {
  //         var _embedded_items = entry['_embedded_items'];
  //         var keys = _embedded_items.keys;
  //         for (var key in keys) {
  //           var itemsArray = entry['_embedded_items'][key];
  //           var content = Automate.findEmbeddedEntry(itemsArray, metadata);
  //           if (content != null) {
  //             return Automate.getStringOption(option, metadata, content);
  //           }
  //         }
  //       }
  //     } else {
  //       String call(children) {
  //         return Automate.rawProcessing(children, entry, option);
  //       }

  //       return option.renderNode(nodeStyle, item, call);
  //     }
  //   }
  //   return '';
  // }

  // static String _getStringOption(Option option, Metadata meta, Map content) {
  //   var stringOption = option.renderOption(content, meta);
  //   return stringOption;
  // }

  // static Metadata _returnMetadata(Map item, nodeStyle) {
  //   LinkedHashMap<dynamic, dynamic> attr = item['attrs'];
  //   var text = Automate.getChildText(item);
  //   var style = attr['display-type'];
  //   if (attr['type'] == 'asset') {
  //     return Metadata(
  //         text: text,
  //         itemType: nodeStyle,
  //         itemUid: attr['asset-uid'],
  //         contentTypeUid: 'sys-asset',
  //         styleType: style,
  //         attributes: attr);
  //   } else {
  //     return Metadata(
  //         text: text,
  //         itemType: nodeStyle,
  //         itemUid: attr['entry-uid'],
  //         contentTypeUid: 'content-type-uid',
  //         styleType: style,
  //         attributes: attr);
  //   }
  // }

  // static String _getChildText(Map item) {
  //   var text = '';
  //   if (item.containsKey('children')) {
  //     var children = item['children'];
  //     for (Map child in children) {
  //       if (child.containsKey(text)) {
  //         text = child['text'];
  //       }
  //     }
  //   }
  //   return text;
  // }
}
