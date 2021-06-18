// genhtml -o coverage coverage/lcov.info
// pub run test

import 'dart:convert' show json;
import 'dart:io' show File;
import 'package:logger/logger.dart';
import 'package:test/test.dart';

void main() {
  var logger = Logger(printer: PrettyPrinter());

  test('test file decoder is working fine', () {
    final _entryArray =
        json.decode(File('test/mock/embedded_items.json').readAsStringSync());
    final _item = _entryArray['entries'][0];
    logger.i(_item);
    expect('Entry one', _item['title']);
  });

  // test('test from helper check isValidJson', () async {
  //   final _entryArray =
  //       json.decode(File('test/mock/embedded_items.json').readAsStringSync());
  //   final _item = _entryArray['entries'][0];
  //   final isValidEntry = UtilityHelper.isValidJson(_item);
  //   expect(true, isValidEntry);
  // });
  //
  // test('check is render function with object', () async {
  //   final _entryArray =
  //       json.decode(File('test/mock/embedded_items.json').readAsStringSync());
  //   final _item = _entryArray['entries'][0];
  //   final callback = Option.entry(_item);
  //   final rteString = [
  //     'global_rich.modular_blocks.rich_in_modular.rich_text_editor'
  //   ];
  //   Utils.render(_item, rteString, callback);
  // });
  //
  // test('utils.render pass invalid json to cover exception', () {
  //   final _entryArray =
  //       json.decode(File('test/mock/embedded_items.json').readAsStringSync());
  //   final _item = _entryArray['entries'][0];
  //   final optionCallback = Option.entry(_item);
  //   final rteKeys = [
  //     'global_rich.modular_blocks.rich_in_modular.rich_text_editor'
  //   ];
  //   Utils.render('_item', rteKeys, optionCallback);
  // });
  //
  // test('utils.render with list of objects', () {
  //   final _entryArray =
  //       json.decode(File('test/mock/embedded_items.json').readAsStringSync());
  //   final _items = _entryArray['entries'];
  //   final optionCallback = Option.entry(_items[0]);
  //   final rteKeys = [
  //     'global_rich.modular_blocks.rich_in_modular.rich_text_editor'
  //   ];
  //   Utils.render(_items, rteKeys, optionCallback);
  //   expect(_items, isA<List>());
  // });
  //
  // test('utils.render inside render content', () {
  //   final _entryArray =
  //       json.decode(File('test/mock/embedded_items.json').readAsStringSync());
  //   final _items = _entryArray['entries'][0];
  //   final optionCallback = Option.entry(_items);
  //   final rteKeys = [
  //     'global_rich.modular_blocks.rich_in_modular.rich_text_editor'
  //   ];
  //   Utils.render(_items, rteKeys, optionCallback);
  // });
  //
  // test('options functions', () {
  //   final _entryArray =
  //       json.decode(File('test/mock/embedded_items.json').readAsStringSync());
  //   final _embedded_object = _entryArray['entries'][0];
  //   prints(_embedded_object);
  //   logger.d(_embedded_object);
  // });
}
