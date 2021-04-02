import 'dart:convert';
import 'package:logger/logger.dart';

var logger = Logger(printer: PrettyPrinter());

class UtilityHelper {
  static bool isValidJson(jsonString) {
    try {
      if (jsonString is String) {
        json.decode(jsonString) as Map<dynamic, dynamic>;
      }
      return true;
    } on FormatException catch (e) {
      logger.w('The provided file is not valid JSON ${e.message}');
      return false;
    }
  }

  // static String metadataText(container) {
  //   if (container.isNotEmpty) {
  //     if (container[0].nodes[0] is Text) {
  //       return container[0].nodes[0].toString();
  //     }
  //     return '';
  //   }
  //   return '';
  // }
}
