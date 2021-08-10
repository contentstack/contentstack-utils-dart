import 'package:contentstack_utils/src/model/NodeToHtml.dart';
import 'package:contentstack_utils/src/model/Option.dart';
import 'package:test/expect.dart';
import 'package:test/scaffolding.dart';

void main() {
  test('test NodeToHtml superscript styletype', () {
    final item = {
      'text': 'lorem ipsum lorem ipsum',
      'superscript': 'superscript'
    };

    var option = Option();
    var stringVal = NodeToHtml.textNodeToHtml(item, option);
    expect('<sup>lorem ipsum lorem ipsum</sup>', stringVal);
  });

  test('test NodeToHtml subscript styletype', () {
    final item = {'text': 'lorem ipsum lorem ipsum', 'subscript': 'subscript'};
    var option = Option();
    var stringVal = NodeToHtml.textNodeToHtml(item, option);
    expect('<sub>lorem ipsum lorem ipsum</sub>', stringVal);
  });

  test('test NodeToHtml inlineCode styletype', () {
    final item = {'text': 'lorem ipsum lorem ipsum', 'inlineCode': 'subscript'};

    var option = Option();
    var stringVal = NodeToHtml.textNodeToHtml(item, option);
    expect('<span>lorem ipsum lorem ipsum</span>', stringVal);
  });

  test('test NodeToHtml strikethrough styletype', () {
    final item = {
      'text': 'lorem ipsum lorem ipsum',
      'strikethrough': 'subscript'
    };

    var option = Option();
    var stringVal = NodeToHtml.textNodeToHtml(item, option);
    expect('<strike>lorem ipsum lorem ipsum</strike>', stringVal);
  });

  test('test NodeToHtml underline styletype', () {
    final item = {'text': 'lorem ipsum lorem ipsum', 'underline': 'subscript'};

    var option = Option();
    var stringVal = NodeToHtml.textNodeToHtml(item, option);
    expect('<u>lorem ipsum lorem ipsum</u>', stringVal);
  });

  test('test NodeToHtml italic styletype', () {
    final item = {'text': 'lorem ipsum lorem ipsum', 'italic': 'subscript'};

    var option = Option();
    var stringVal = NodeToHtml.textNodeToHtml(item, option);
    expect('<em>lorem ipsum lorem ipsum</em>', stringVal);
  });

  test('test NodeToHtml bold styletype', () {
    final item = {'text': 'lorem ipsum lorem ipsum', 'bold': 'subscript'};

    var option = Option();
    var stringVal = NodeToHtml.textNodeToHtml(item, option);
    expect('<strong>lorem ipsum lorem ipsum</strong>', stringVal);
  });
}
