import 'dart:collection';
import 'dart:convert';
import 'package:html/parser.dart' show parse;
import 'package:contentstack_utils/contentstack_utils.dart';
import 'package:contentstack_utils/src/model/NodeToHtml.dart';
import 'package:contentstack_utils/src/model/Option.dart';
import 'package:logger/logger.dart';

var logger = Logger(printer: PrettyPrinter());

class Automate {
  static bool isValidJson(jsonString) {
    try {
      if (jsonString is String) {
        json.decode(jsonString) as Map<dynamic, dynamic>;
      }
      return true;
    } on FormatException catch (e) {
      logger.w('Entry json file is not valid ${e.message}');
      return false;
    }
  }

  static Map findEmbeddedItems(Map jsonObject, Metadata metadata) {
    var keys = jsonObject.keys;
    for (var item in keys) {
      List jsonArray = jsonObject[item];
      var filteredContent = jsonArray
          .firstWhere((element) => element['uid'] == metadata.getItemUid);
      return filteredContent;
    }
    return null;
  }

  static void getEmbeddedItems(stringHtml, Function(Metadata) callback) {
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

  static void find_embed_keys(
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

  static Object enumerateContent(content, entry, option) {
    if (content is List) {
      var arrayContent = [];
      for (var item in content) {
        var result = Automate.enumerateContent(item, entry, option);
        arrayContent.add(result);
      }
      return arrayContent;
    }

    if (content is Map) {
      if (content.containsKey('type') && content.containsKey('children')) {
        if (content['type'] == 'doc') {
          return Automate.rawProcessing(content['children'], entry, option);
        }
      }
    }
    return '';
  }

  static String rawProcessing(children, entry, option) {
    var array_container = [];
    for (var item in children) {
      if (item is Map) {
        array_container.add(Automate.extractKey(item, entry, option));
      }
    }
    return array_container.join('');
  }

  static String extractKey(Map item, Map entry, Option option) {
    if (!item.containsKey('type') && item.containsKey('text')) {
      return NodeToHtml.textNodeToHtml(item, option);
    } else if (item.containsKey('type')) {
      var nodeStyle = item['type'];
      if (nodeStyle == 'reference') {
        var metadata = Automate.returnMetadata(item, nodeStyle);
        if (entry.containsKey('_embedded_items')) {
          var _embedded_items = entry['_embedded_items'];
          var keys = _embedded_items.keys;
          for (var key in keys) {
            var itemsArray = entry['_embedded_items'][key];
            var content = Automate.findEmbeddedEntry(itemsArray, metadata);
            if (content != null) {
              return Automate.getStringOption(option, metadata, content);
            }
          }
        } else if (entry.containsKey('edges') &&
            entry['edges'] is List<dynamic>) {
          var itemsArray = entry['edges'];
          var content = Automate.findEmbeddedEntry(itemsArray, metadata);
          if (content != null) {
            return Automate.getStringOption(option, metadata, content);
          }
        }
      } else {
        String call(children) {
          return Automate.rawProcessing(children, entry, option);
        }

        return option.renderNode(nodeStyle, item, call);
      }
    }
    return '';
  }

  static Metadata returnMetadata(Map item, nodeStyle) {
    LinkedHashMap<dynamic, dynamic> attr = item['attrs'];
    var text = Automate.getChildText(item);
    var style = attr['display-type'];
    if (attr['type'] == 'asset') {
      return Metadata(
          text: text,
          itemType: nodeStyle,
          itemUid: attr['asset-uid'],
          contentTypeUid: 'sys-asset',
          styleType: style,
          attributes: attr);
    } else {
      return Metadata(
          text: text,
          itemType: nodeStyle,
          itemUid: attr['entry-uid'],
          contentTypeUid: 'content-type-uid',
          styleType: style,
          attributes: attr);
    }
  }

  static Object findEmbeddedEntry(List jsonList, Metadata metadata) {
    for (var obj in jsonList) {
      if (obj is Map) {
        if (obj['uid'] == metadata.getItemUid) {
          return obj;
        } else if (obj.containsKey('node')) {
          Map node = obj['node'];
          if (node.containsKey('system')) {
            Map system = node['system'];
            if (system.containsKey('uid') &&
                system['uid'] == metadata.getItemUid) {
              return node;
            }
          }
        }
      }
    }
    return null;
  }

  static String getStringOption(Option option, Metadata meta, Map content) {
    var stringOption = option.renderOption(content, meta);
    return stringOption;
  }

  static String getChildText(Map item) {
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
