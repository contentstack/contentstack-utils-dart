// genhtml -o coverage coverage/lcov.info
// pub run test

import 'dart:convert' show json;
import 'dart:io' show File;
import 'package:contentstack_utils/contentstack_utils.dart';
import 'package:contentstack_utils/src/model/Option.dart';
import 'package:test/test.dart';
import 'mock/supercharged/results/results.dart';

void main() {
  var _entry;

  setUp(() {
    const mockBasePath = 'test/mock/supercharged/';
    const FILE_PATH = mockBasePath + 'supercharged.json';
    _entry = json.decode(File(FILE_PATH).readAsStringSync());
  });

  test('test supercharged rte check for valid entry json file', () {
    final callback = Option.entry(_entry);
    Utils.jsonToHTML(_entry, ['paragraph'], callback);
    expect('Test Rich Text', _entry['title']);
  });

  test('test supercharged rte plaintext html', () {
    final callback = Option.entry(_entry);
    Utils.jsonToHTML(_entry, ['plaintext'], callback);
    expect(Result.plainTextHtml, _entry['plaintext']);
  });

  test('test supercharged rte paragraph html', () {
    final callback = Option.entry(_entry);
    Utils.jsonToHTML(_entry, ['paragraph'], callback);
    expect(Result.paragraphHtml, _entry['paragraph']);
  });

  test('test supercharged rte h_one html', () {
    final callback = Option.entry(_entry);
    Utils.jsonToHTML(_entry, ['h_one'], callback);
    expect(Result.h1Html, _entry['h_one']);
  });

  test('test supercharged rte h_two html', () {
    final callback = Option.entry(_entry);
    Utils.jsonToHTML(_entry, ['h_two'], callback);
    expect(Result.h2Html, _entry['h_two']);
  });

  test('test supercharged rte h_three html', () {
    final callback = Option.entry(_entry);
    Utils.jsonToHTML(_entry, ['h_three'], callback);
    expect(Result.h3Html, _entry['h_three']);
  });

  test('test supercharged rte h_three html', () {
    final callback = Option.entry(_entry);
    Utils.jsonToHTML(_entry, ['h_four'], callback);
    expect(Result.h4Html, _entry['h_four']);
  });

  test('test supercharged rte h_three html', () {
    final callback = Option.entry(_entry);
    Utils.jsonToHTML(_entry, ['h_five'], callback);
    expect(Result.h5Html, _entry['h_five']);
  });

  test('test supercharged rte h_six html', () {
    final callback = Option.entry(_entry);
    Utils.jsonToHTML(_entry, ['h_six'], callback);
    expect(Result.h6Html, _entry['h_six']);
  });

  test('test supercharged rte order_list html', () {
    final callback = Option.entry(_entry);
    Utils.jsonToHTML(_entry, ['order_list'], callback);
    expect(Result.orderListHtml, _entry['order_list']);
  });

  test('test supercharged rte un_order_list html', () {
    final callback = Option.entry(_entry);
    Utils.jsonToHTML(_entry, ['un_order_list'], callback);
    expect(Result.unorderListHtml, _entry['un_order_list']);
  });

  test('test supercharged rte img html', () {
    final callback = Option.entry(_entry);
    Utils.jsonToHTML(_entry, ['img'], callback);
    expect(Result.imgHtml, _entry['img']);
  });

  test('test supercharged rte table html', () {
    final callback = Option.entry(_entry);
    Utils.jsonToHTML(_entry, ['table'], callback);
    expect(Result.tableHtml, _entry['table']);
  });

  test('test supercharged rte blockquote html', () {
    final callback = Option.entry(_entry);
    Utils.jsonToHTML(_entry, ['blockquote'], callback);
    expect(Result.blockquoteHtml, _entry['blockquote']);
  });

  test('test supercharged rte code html', () {
    final callback = Option.entry(_entry);
    Utils.jsonToHTML(_entry, ['code'], callback);
    expect(Result.codeHtml, _entry['code']);
  });

  test('test supercharged rte link html', () {
    final callback = Option.entry(_entry);
    Utils.jsonToHTML(_entry, ['link'], callback);
    expect(Result.linkInPHtml, _entry['link']);
  });

  test('test supercharged rte reference html', () {
    final callback = Option.entry(_entry);
    Utils.jsonToHTML(_entry, ['reference'], callback);
    expect(Result.refernce, _entry['reference']);
  });
}
