import 'package:contentstack_utils/src/helper/Metadata.dart';
import 'package:contentstack_utils/src/model/Option.dart';

class OptionDemo implements Option {
  @override
  String renderMark(String markType, String renderText) {
    // TODO: implement renderMark
    switch (markType) {
      case 'bold':
        return '<b>' + renderText + '</b>';
        break;
      default:
        return '';
    }
  }

  @override
  String renderNode(nodeType, Map node_obj, callback) {
    // TODO: implement renderNode
    switch (nodeType) {
      case 'paragraph':
        String children = callback.renderChildren(node_obj['children']);
        return "<p class='class-id'>" + children + '</p>';
        break;
      default:
        return '';
    }
  }

  @override
  String renderOption(Map obj, Metadata metadata) {
    switch (metadata.getStyleType) {
      case 'block':
        return '<p>' + obj['title'] + '</p><span>' + obj['multi'] + '</span>';
        break;
      case 'inline':
        return '<p>' + obj['title'] + '</p><span>' + obj['line'] + '</span>';
        break;
      case 'link':
        return '<p>' + obj['title'] + '</p><span>' + obj['key'] + '</span>';
        break;
      case 'display':
        return '<p>' + obj['title'] + '</p><span>' + obj['multi'] + '</span>';
        break;
      default:
        return '';
    }
  }
}
