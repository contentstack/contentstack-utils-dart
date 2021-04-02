// genhtml -o coverage coverage/lcov.info
// pub run test

import 'dart:convert' show json;
import 'dart:io' show File;

import 'package:contentstack_utils/src/helper/UtilityHelper.dart';
import 'package:contentstack_utils/src/model/Option.dart';
import 'package:contentstack_utils/utils.dart';
import 'package:test/test.dart';

void main() {
  // html string for entry
  const __stringHtmlEntry =
      // ignore: prefer_single_quotes
      // ignore: avoid_escaping_inner_quotes
      '<p>Global multiple 2<span class=\"redactor-component embedded-entry inline-entry\" data-redactor-type=\"embed\" data-widget-code=\"\" data-sys-entry-uid=\"bltba476c60baacb442\" data-sys-entry-locale=\"en-us\" data-sys-content-type-uid=\"0_solve\" data-sys-can-edit=\"true\" sys-style-type=\"inline\" type=\"entry\"></span></p>';

  test('test file decoder is woring fine', () {
    final _entryArray =
        json.decode(File('test/mock/embedded_items.json').readAsStringSync());
    final _item = _entryArray['entries'][0];
    // ignore: avoid_print
    print(_item);
    expect('Entry one', _item['title']);
  });

  test('test from helper check isValidJson', () async {
    final _entryArray =
        json.decode(File('test/mock/embedded_items.json').readAsStringSync());
    final _item = _entryArray['entries'][0];
    final isValidEntry = UtilityHelper.isValidJson(_item);
    expect(true, isValidEntry);
  });

  test('check is render function with object', () async {
    final _entryArray =
        json.decode(File('test/mock/embedded_items.json').readAsStringSync());
    final _item = _entryArray['entries'][0];
    final callback = Option.entry(_item);
    final rteString = [
      'global_rich.modular_blocks.rich_in_modular.rich_text_editor'
    ];
    Utils.render(_item, rteString, callback);
  });

  test('check is render function with render content', () async {
    final _entryArray =
        json.decode(File('test/mock/embedded_items.json').readAsStringSync());
    final _item = _entryArray['entries'][0];
    final option = Option.entry(_item);
    final rteKeys = [
      'global_rich.modular_blocks.rich_in_modular.rich_text_editor'
    ];
    // ignore: avoid_print
    print(rteKeys);
    final result = Utils.renderContent(__stringHtmlEntry, _item, option);
    // ignore: avoid_print
    print(result);
  });
}
