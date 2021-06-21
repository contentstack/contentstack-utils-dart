import 'package:contentstack_utils/src/model/Option.dart';

class NodeToHtml {
  static String textNodeToHtml(Map item, Option option) {
    var nodeText = item['text'];
    if (item.containsKey('superscript')) {
      return nodeText = option.renderMark('superscript', nodeText);
    } else if (item.containsKey('subscript')) {
      return nodeText = option.renderMark('subscript', nodeText);
    } else if (item.containsKey('inlineCode')) {
      return nodeText = option.renderMark('inlineCode', nodeText);
    } else if (item.containsKey('strikethrough')) {
      return nodeText = option.renderMark('strikethrough', nodeText);
    } else if (item.containsKey('underline')) {
      return nodeText = option.renderMark('underline', nodeText);
    } else if (item.containsKey('italic')) {
      return nodeText = option.renderMark('italic', nodeText);
    } else if (item.containsKey('bold')) {
      return nodeText = option.renderMark('bold', nodeText);
    }
    return nodeText;
  }
}


