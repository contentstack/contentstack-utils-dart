import 'package:contentstack_utils/src/helper/Automate.dart';
import 'package:contentstack_utils/src/model/Option.dart';

class GQL {
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
          if (rteContent is Map) {
            var embedItems = rteContent['embedded_itemsConnection'] ?? {};

            var _json = rteContent['json'];
            if (_json is List<dynamic>) {
              var _resultArray = [];
              for (var item in _json) {
                var _contentStr =
                    Automate.enumerateContent(item, embedItems, option);
                _resultArray.add(_contentStr);
              }
              return _resultArray;
            } else if (_json is Map) {
              return Automate.enumerateContent(_json, embedItems, option);
            }
          }
          return '';
        });
      }
    }
  }
}
