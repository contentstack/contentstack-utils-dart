// genhtml -o coverage coverage/lcov.info
// pub run test

import 'dart:convert' show json;
import 'dart:io' show File;

import 'package:contentstack_utils/Utils.dart';
import 'package:contentstack_utils/src/helper/UtilityHelper.dart';
import 'package:contentstack_utils/src/model/Option.dart';
import 'package:test/test.dart';

void main() {
  // html string for entry
  var __stringHtmlEntry =
      // ignore: prefer_single_quotes
      "<p>Global multiple 2<span class=\"redactor-component embedded-entry inline-entry\" data-redactor-type=\"embed\" data-widget-code=\"\" data-sys-entry-uid=\"bltba476c60baacb442\" data-sys-entry-locale=\"en-us\" data-sys-content-type-uid=\"0_solve\" data-sys-can-edit=\"true\" sys-style-type=\"inline\" type=\"entry\"></span></p>";

  test('test file decoder is woring fine', () {
    var _entryArray =
        json.decode(File('test/mock/embedded_items.json').readAsStringSync());
    var _item = _entryArray['entries'][0];
    print(_item);
    expect('Entry one', _item['title']);
  });

  test('test from helper check isValidJson', () async {
    var _entryArray =
        json.decode(File('test/mock/embedded_items.json').readAsStringSync());
    var _item = _entryArray['entries'][0];
    var isValidEntry = UtilityHelper.isValidJson(_item);
    expect(true, isValidEntry);
  });

  test('check is render function with object', () async {
    var _entryArray =
        json.decode(File('test/mock/embedded_items.json').readAsStringSync());
    var _item = _entryArray['entries'][0];
    var callback = Option.entry(_item);
    var rteString = [
      'global_rich.modular_blocks.rich_in_modular.rich_text_editor'
    ];
    Utils.render(_item, rteString, callback);
  });

  test('check is render function with render content', () async {
    var _entryArray =
        json.decode(File('test/mock/embedded_items.json').readAsStringSync());
    var _item = _entryArray['entries'][0];
    var option = Option.entry(_item);
    var rteKeys = [
      'global_rich.modular_blocks.rich_in_modular.rich_text_editor'
    ];
    print(rteKeys);
    var result = Utils.renderContent(__stringHtmlEntry, _item, option);
    print(result);
  });
}
