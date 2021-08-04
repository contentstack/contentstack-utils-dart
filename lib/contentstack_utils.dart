library contentstack_utils;

import 'package:contentstack_utils/src/helper/Automate.dart';
import 'package:contentstack_utils/src/model/Option.dart';
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

  static Object renderContent(rteString, Map embedObject, Option option) async {
    if (rteString is String) {
      var available = embedObject.containsKey('_embedded_items');
      if (available) {
        var jsonArray = embedObject['_embedded_items'];
        Automate.getEmbeddedItems(rteString, (metadata) {
          var filteredContent = Automate.findEmbeddedItems(jsonArray, metadata);
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
}
