// genhtml -o coverage coverage/lcov.info
// pub run test

import 'dart:convert' show json;
import 'dart:io' show File;
import 'package:contentstack_utils/contentstack_utils.dart';
import 'package:contentstack_utils/src/model/Option.dart';
import 'package:logger/logger.dart';
import 'package:test/test.dart';

import 'mock/supercharged/results/results.dart';

void main() {
  var logger = Logger(printer: PrettyPrinter());

  test('test supercharged rte check for valid entry json file', () {
    final _entryArray = json.decode(
        File('test/mock/supercharged/supercharged.json').readAsStringSync());
    logger.i(_entryArray['title']);
    const paragraph = ['paragraph'];
    final callback = Option.entry(_entryArray);
    Utils.jsonToHTML(_entryArray, paragraph, callback);
    expect('Entry one', _entryArray['title']);
  });

  test('test supercharged rte plaintext html', () {
    final _entryArray = json.decode(
        File('test/mock/supercharged/supercharged.json').readAsStringSync());
    logger.i(_entryArray['title']);

    const paragraph = ['plaintext'];
    final callback = Option.entry(_entryArray);
    Utils.jsonToHTML(_entryArray, paragraph, callback);

    expect(Result.plainTextHtml, _entryArray['plaintext']);
  });
}
