import 'dart:convert';

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
}
