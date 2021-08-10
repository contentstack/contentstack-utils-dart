import 'package:contentstack_utils/src/model/Option.dart';
import 'package:test/expect.dart';
import 'package:test/scaffolding.dart';

void main() {
  test('test option superscript styletype', () {
    final item = {
      'children': 'lorem ipsum lorem ipsum',
      'attrs': {'url': 'www.google.com/lorem'}
    };
    print(item);
    // var option = Option().renderNode('p', item, callback);
    // expect('<sup>lorem ipsum lorem ipsum</sup>', option);
  });

  test('test option subscript styletype', () {
    var option = Option().renderMark('subscript', 'lorem ipsum lorem ipsum');
    expect('<sub>lorem ipsum lorem ipsum</sub>', option);
  });

  test('test option inlineCode styletype', () {
    var option = Option().renderMark('inlineCode', 'lorem ipsum lorem ipsum');
    expect('<span>lorem ipsum lorem ipsum</span>', option);
  });

  test('test option strikethrough styletype', () {
    var option =
        Option().renderMark('strikethrough', 'lorem ipsum lorem ipsum');
    expect('<strike>lorem ipsum lorem ipsum</strike>', option);
  });

  test('test option underline styletype', () {
    var option = Option().renderMark('underline', 'lorem ipsum lorem ipsum');
    expect('<u>lorem ipsum lorem ipsum</u>', option);
  });

  test('test option italic styletype', () {
    var option = Option().renderMark('italic', 'lorem ipsum lorem ipsum');
    expect('<em>lorem ipsum lorem ipsum</em>', option);
  });

  test('test option bold styletype', () {
    var option = Option().renderMark('bold', 'lorem ipsum lorem ipsum');
    expect('<strong>lorem ipsum lorem ipsum</strong>', option);
  });
}
