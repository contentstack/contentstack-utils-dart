import 'package:contentstack_utils/src/embedded/ItemType.dart';
import 'package:test/test.dart';

void main() {
  test('test ItemType.asset', () {
    var _itemAsset = ItemType.asset;
    var __itemAsset = _itemAsset.toString().split('.')[1];
    expect('asset', __itemAsset);
  });

  test('test ItemType.entry', () {
    var _itemEntry = ItemType.entry;
    var __itemEntry = _itemEntry.toString().split('.')[1];
    expect('entry', __itemEntry);
  });
}
