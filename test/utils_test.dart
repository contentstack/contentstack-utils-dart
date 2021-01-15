import 'dart:convert';
import 'dart:io';

import 'package:test/test.dart';

import 'package:contentstack_utils/Utils.dart';
import 'package:contentstack_utils/src/helper/UtilityHelper.dart';

void main() {
  test('check is valid file', () async {
    final file = File('test/mock/json/embedded_items.json');
    final json = jsonDecode(await file.readAsString());
    final entries = json['entries'];
    var isValidEntry = UtilityHelper.isValidJson(entries);
    expect(true, isValidEntry);
    var isValid = UtilityHelper.isValidJson(json);
    expect(true, isValid);
  });

  test('check is render function with object', () async {
    final file = File('test/mock/json/multiple_rich_text_content.json');
    final json = jsonDecode(await file.readAsString());
    final entries = json['entries'][0];
    var callback = OptionCallback();
    var rteString = [
      'global_rich.modular_blocks.rich_in_modular.rich_text_editor'
    ];
    Utils.render(entries, rteString, callback);
  });

  test('check is render function with list', () async {
    final file = File('test/mock/json/multiple_rich_text_content.json');
    final json = jsonDecode(await file.readAsString());
    final entries = json['entries'];
    var callback = OptionCallback();
    Utils.render(entries, [], callback);
  });

  test('test render metadata', () async {
    final file = File('test/mock/json/multiple_rich_text_content.json');
    final json = jsonDecode(await file.readAsString());
    final entries = json['entries'];
    var callback = OptionCallback();
    Utils.render(entries, [], callback);
  });

  test('test on embedded assets', () {
    var embedded_asset_string =
        '<figure class="embedded-asset" data-redactor-type="embed" data-widget-code="" data-sys-asset-filelink="https://dev16-images.contentstack.com/v3/assets/blt77263d300aee3e6b/blt7324a68403ee7281/5f83f543d418e407f919e0e4/11.jpg" data-sys-asset-uid="blt7324a68403ee7281" data-sys-asset-filename="11.jpg" data-sys-asset-contenttype="image/jpeg" type="asset" sys-style-type="display"></figure>';
    print(embedded_asset_string);
  });

  test('test on embedded render content', () async {
    final file = File('test/mock/json/multiple_rich_text_content.json');
    final json = jsonDecode(await file.readAsString());
    final entries = json['entries'][0];
    var rteStringify =
        '<figure class="embedded-asset" data-redactor-type="embed" data-widget-code="" data-sys-asset-filelink="https://dev16-images.contentstack.com/v3/assets/blt77263d300aee3e6b/blt7324a68403ee7281/5f83f543d418e407f919e0e4/11.jpg" data-sys-asset-uid="blt7324a68403ee7281" data-sys-asset-filename="11.jpg" data-sys-asset-contenttype="image/jpeg" type="asset" sys-style-type="display"></figure>';
    // Utils.renderContent(rteStringify, entries, OptionCallback().renderOptions((rteStringify, js ) {
    //
    // }));
  });
}
