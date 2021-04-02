import 'package:contentstack_utils/Utils.dart';
import 'package:test/test.dart';

void main() {
  test('test ItemType.block', () {
    const _itemBlock = StyleType.block;
    final __itemBlock = _itemBlock.toString().split('.').last;
    expect('block', __itemBlock);
  });

  test('test ItemType.inline', () {
    const _itemInline = StyleType.inline;
    final __itemInline = _itemInline.toString().split('.').last;
    expect('inline', __itemInline);
  });

  test('test ItemType.linked', () {
    const _itemLinked = StyleType.linked;
    final __itemLinked = _itemLinked.toString().split('.').last;
    expect('linked', __itemLinked);
  });

  test('test ItemType.display', () {
    const _itemDisplay = StyleType.display;
    final __itemDisplay = _itemDisplay.toString().split('.').last;
    expect('display', __itemDisplay);
  });

  test('test ItemType.download', () {
    const _itemDownload = StyleType.download;
    final __itemDownload = _itemDownload.toString().split('.').last;
    expect('download', __itemDownload);
  });
}
