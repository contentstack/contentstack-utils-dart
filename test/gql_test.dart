// genhtml -o coverage coverage/lcov.info
// pub run test

import 'dart:convert' show json;
import 'dart:io' show File;

import 'package:test/test.dart';

void main() {
  var _entry;

  setUp(() {
    const mockBasePath = 'test/mock/graphqlmock/';
    const FILE_PATH = mockBasePath + 'content.json';
    _entry = json.decode(File(FILE_PATH).readAsStringSync());
  });

  test('test file decoder is working fine', () {
    final _item = _entry['srte'];
    expect('sameple_uid', _item['json'][0]['uid']);
  });
}
