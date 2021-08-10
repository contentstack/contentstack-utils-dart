import 'package:contentstack_utils/src/model/Option.dart';

class NodeToHtml {
  static String textNodeToHtml(Map item, Option option) {
    var nodeText = item['text'];
    if (item.containsKey('superscript')) {
      nodeText = option.renderMark('superscript', nodeText);
    }
    if (item.containsKey('subscript')) {
      nodeText = option.renderMark('subscript', nodeText);
    }
    if (item.containsKey('inlineCode')) {
      nodeText = option.renderMark('inlineCode', nodeText);
    }
    if (item.containsKey('strikethrough')) {
      nodeText = option.renderMark('strikethrough', nodeText);
    }
    if (item.containsKey('underline')) {
      nodeText = option.renderMark('underline', nodeText);
    }
    if (item.containsKey('italic')) {
      nodeText = option.renderMark('italic', nodeText);
    }
    if (item.containsKey('bold')) {
      nodeText = option.renderMark('bold', nodeText);
    }
    return nodeText;
  }
}
