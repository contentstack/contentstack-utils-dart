// genhtml -o coverage coverage/lcov.info
// pub run test

import 'dart:convert' show json;
import 'dart:io' show File;
import 'package:contentstack_utils/contentstack_utils.dart';
import 'package:contentstack_utils/src/model/Option.dart';
import 'package:test/test.dart';

import 'mock/supercharged/results/results.dart';

void main() {
  //var logger = Logger(printer: PrettyPrinter());
  const mockBasePath = 'test/mock/supercharged/';
  const FILE_PATH = mockBasePath + 'supercharged.json';
  final _entry = json.decode(File(FILE_PATH).readAsStringSync());

  test('test supercharged rte check for valid entry json file', () {
    final callback = Option.entry(_entry);
    Utils.jsonToHTML(_entry, ['paragraph'], callback);
    expect('Test Rich Text', _entry['title']);
  });

  test('test supercharged rte plaintext html', () {
    final callback = Option.entry(_entry);
    Utils.jsonToHTML(_entry, ['plaintext'], callback);
    expect(Result.plainTextHtml, _entry['plaintext']);
  });
}
