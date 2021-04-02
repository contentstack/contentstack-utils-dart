import 'package:contentstack_utils/src/embedded/ItemType.dart';
import 'package:contentstack_utils/utils.dart';
import 'package:html/parser.dart' show parse;
import 'package:test/test.dart';

void main() {
  // html string for asset
  const __stringHtmlAsset =
      // ignore: prefer_single_quotes
      // ignore: avoid_escaping_inner_quotes
      '<p>module 2&nbsp;</p><figure class=\"embedded-asset\" data-redactor-type=\"embed\" data-widget-code=\"\" data-sys-asset-filelink=\"https://dev16-images.contentstack.com/v3/assets/blt77263d300aee3e6b/blt7324a68403ee7281/5f83f543d418e407f919e0e4/11.jpg\" data-sys-asset-uid=\"blt7324a68403ee7281\" data-sys-asset-filename=\"11.jpg\" data-sys-asset-contenttype=\"image/jpeg\" type=\"asset\" sys-style-type=\"display\"></figure>';
  // html string for entry
  const __stringHtmlEntry =
      // ignore: prefer_single_quotes
      // ignore: avoid_escaping_inner_quotes
      '<p>Global multiple 2<span class=\"redactor-component embedded-entry inline-entry\" data-redactor-type=\"embed\" data-widget-code=\"\" data-sys-entry-uid=\"blt49af3673cdd268a5\" data-sys-entry-locale=\"en-us\" data-sys-content-type-uid=\"0_solve\" data-sys-can-edit=\"true\" sys-style-type=\"inline\" type=\"entry\"></span></p>';

  test('test metadata asset styletype', () {
    final document = parse(__stringHtmlAsset);
    final containerAsset = document.getElementsByClassName('embedded-asset');
    if (containerAsset.isNotEmpty) {
      // ignore: avoid_function_literals_in_foreach_calls
      containerAsset.forEach((element) {
        final metadata = Metadata.element(element);
        // ignore: avoid_print
        print(metadata.getStyleType);
        expect('display', metadata.getStyleType);
      });
    }
  });

  test('test metadata asset itemtype', () {
    final document = parse(__stringHtmlAsset);
    final containerAsset = document.getElementsByClassName('embedded-asset');
    if (containerAsset.isNotEmpty) {
      // ignore: avoid_function_literals_in_foreach_calls
      containerAsset.forEach((element) {
        final metadata = Metadata.element(element);
        // ignore: avoid_print
        print(metadata.getItemType);
        expect('asset', metadata.getItemType);
      });
    }
  });

  test('test metadata entry itemtype', () {
    final document = parse(__stringHtmlEntry);
    final containerAsset = document.getElementsByClassName('embedded-entry');
    if (containerAsset.isNotEmpty) {
      // ignore: avoid_function_literals_in_foreach_calls
      containerAsset.forEach((element) {
        final metadata = Metadata.element(element);
        // ignore: avoid_print
        print(metadata.getStyleType);
        expect('entry', metadata.getItemType);
      });
    }
  });

  test('test metadata entry all params', () {
    final document = parse(__stringHtmlEntry);
    final containerAsset = document.getElementsByClassName('embedded-entry');
    if (containerAsset.isNotEmpty) {
      // ignore: avoid_function_literals_in_foreach_calls
      containerAsset.forEach((element) {
        final metadata = Metadata.element(element);
        // ================ //
        expect('0_solve', metadata.getContentTypeUid);
        expect('entry', metadata.getItemType);
        expect('blt49af3673cdd268a5', metadata.getItemUid);
        expect('inline', metadata.getStyleType);
        expect('', metadata.getText);
      });
    }
  });

  test('test ItemType.entry', () {
    const _itemEntry = ItemType.entry;
    final __itemEntry = _itemEntry.toString().split('.').last;
    expect('entry', __itemEntry);
  });
}
