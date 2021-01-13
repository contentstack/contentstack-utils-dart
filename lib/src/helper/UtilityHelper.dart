
import 'dart:convert';

class UtilityHelper{

  static bool isValidJson(jsonString){
    try {
      if (jsonString is String){
        json.decode(jsonString) as Map<dynamic, dynamic>;
      }
      return true;
    } on FormatException catch (e) {
      print('The provided string is not valid JSON ${e.message}');
      return false;
    }
  }
}