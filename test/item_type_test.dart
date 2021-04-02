import 'package:contentstack_utils/src/embedded/ItemType.dart';
import 'package:logger/logger.dart';
import 'package:test/test.dart';

void main() {
  var logger = Logger(printer: PrettyPrinter());
  test('test ItemType.asset', () {
    const _itemAsset = ItemType.asset;
    final __itemAsset = _itemAsset.toString().split('.')[1];
    logger.d(__itemAsset);
    expect('asset', __itemAsset);
  });

  test('test ItemType.entry', () {
    const _itemEntry = ItemType.entry;
    final __itemEntry = _itemEntry.toString().split('.')[1];
    logger.d(__itemEntry);
    expect('entry', __itemEntry);
  });
}
