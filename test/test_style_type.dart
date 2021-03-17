import 'package:contentstack_utils/Utils.dart';
import 'package:test/test.dart';

void main() {
  test('test ItemType.block', () {
    var _itemBlock = StyleType.block;
    var __itemBlock = _itemBlock.toString().split('.').last;
    expect('block', __itemBlock);
  });

  test('test ItemType.inline', () {
    var _itemInline = StyleType.inline;
    var __itemInline = _itemInline.toString().split('.').last;
    expect('inline', __itemInline);
  });

  test('test ItemType.linked', () {
    var _itemLinked = StyleType.linked;
    var __itemLinked = _itemLinked.toString().split('.').last;
    expect('linked', __itemLinked);
  });

  test('test ItemType.display', () {
    var _itemDisplay = StyleType.display;
    var __itemDisplay = _itemDisplay.toString().split('.').last;
    expect('display', __itemDisplay);
  });

  test('test ItemType.download', () {
    var _itemDownload = StyleType.download;
    var __itemDownload = _itemDownload.toString().split('.').last;
    expect('download', __itemDownload);
  });
}
