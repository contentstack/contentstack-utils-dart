import 'dart:convert' show json;
import 'dart:io' show File;
import 'package:contentstack_utils/src/helper/UtilityHelper.dart';
import 'package:test/test.dart';

void main() {
  test('utility helper testcase not valid json', () {
    var isValidJson = UtilityHelper.isValidJson('jsonString');
    expect(false, isValidJson);
  });

  test('utility helper testcase valid json', () {
    final _entryArray =
        json.decode(File('test/mock/embedded_items.json').readAsStringSync());
    var isValidJson = UtilityHelper.isValidJson(_entryArray);
    expect(true, isValidJson);
  });
}
