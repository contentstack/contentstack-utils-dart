import 'dart:convert';
import 'dart:html';

import 'package:html/dom.dart';

class UtilityHelper {
  static bool isValidJson(jsonString) {
    try {
      if (jsonString is String) {
        json.decode(jsonString) as Map<dynamic, dynamic>;
      }
      return true;
    } on FormatException catch (e) {
      print('The provided file is not valid JSON ${e.message}');
      return false;
    }
  }

  static String metadataText(container) {
    if (container.isNotEmpty) {
      if (container[0].nodes[0] is Text) {
        return container[0].nodes[0].toString();
      }
      return '';
    }
  }
}
