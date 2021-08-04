import 'package:contentstack_utils/contentstack_utils.dart';
import 'package:contentstack_utils/src/helper/Automate.dart';
import 'package:contentstack_utils/src/model/Option.dart';

class GQL {
  static void jsonToHTML(entryObj, List<String> rteKeys, Option option) {
    if (!Automate.isValidJson(entryObj)) {
      throw FormatException('Invalid file, Can not process the json file');
    }

    if (entryObj is List) {
      for (var entry in entryObj) {
        Utils.render(entry, rteKeys, option);
      }
    } else if (entryObj is Map<String, Object>) {
      if (entryObj.containsKey('_embedded_items')) {
        if (rteKeys.isNotEmpty) {
          for (var path in rteKeys) {
            Automate.find_embed_keys(entryObj, path, (rteContent) {
              return Utils.renderContent(rteContent, entryObj, option);
            });
          }
        } else {
          Map<String, Object> embeddedKeys = entryObj['_embedded_items'];
          rteKeys = embeddedKeys.keys.toList();
          embeddedKeys.keys.forEach((keyPath) {
            Automate.find_embed_keys(entryObj, keyPath, (rteContent) {
              return Utils.renderContent(rteContent, entryObj, option);
            });
          });
        }
      }
    } else {
      FormatException('Invalid file for embedded objects');
    }
  }
}
