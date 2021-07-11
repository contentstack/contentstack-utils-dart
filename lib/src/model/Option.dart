import 'package:contentstack_utils/contentstack_utils.dart';

class Option {
  Option();
  Option.entry(Map entry);

  static String _findTitleOrUid(Map obj) {
    var _title = '';
    if (obj.containsKey('title')) {
      _title = obj['title'];
    } else if (obj.containsKey('uid')) {
      _title = obj['uid'];
    }
    return _title;
  }

  static String _findInlineLink(Metadata metadata, Map obj) {
    var _title = '';
    if (metadata.getText.isNotEmpty) {
      _title = metadata.getText;
    } else if (obj.containsKey('title')) {
      _title = obj['title'];
    } else if (obj.containsKey('uid')) {
      _title = obj['uid'];
    }
    return _title;
  }

  static String _findInlineUrl(Map embeddedObject) {
    return embeddedObject['url'];
  }

  static String _findDisplayAtrr(Metadata metadata, Map obj) {
    var _title = '';
    if (metadata.attributes.isNotEmpty) {
      _title = metadata.attributes.toString();
    } else if (obj.containsKey('title')) {
      _title = obj['title'];
    } else if (obj.containsKey('filename')) {
      _title = obj['filename'];
    } else if (obj.containsKey('uid')) {
      _title = obj['uid'];
    }
    return _title;
  }

  String renderOption(Map obj, Metadata metadata) {
    if (metadata.styleType == 'block') {
      return "<div><p>$_findTitleOrUid(embeddedObject)</p><p>Content type: <span>${obj['_content_type_uid']}</span></p></div>";
    }
    if (metadata.styleType == 'inline') {
      return '<span>$_findTitleOrUid(embeddedObject)</span>';
    }
    if (metadata.styleType == 'link') {
      return '<a href=$_findInlineUrl(embeddedObject)>$_findInlineLink(metadata, embeddedObject)</a>';
    }
    if (metadata.styleType == 'display') {
      return '<img src=${_findInlineUrl(obj)} alt=$_findDisplayAtrr(metadata, embeddedObject) />';
    }
    if (metadata.styleType == 'download') {
      return '<a href=${_findInlineUrl(obj)} alt=$_findDisplayAtrr(metadata, embeddedObject) </a>';
    }
    return '';
  }

  String renderMark(String markType, String renderText) {
    if (markType == 'superscript') {
      return '<sup>' + renderText + '</sup>';
    }
    if (markType == 'subscript') {
      return '<sub>' + renderText + '</sub>';
    }
    if (markType == 'inlineCode') {
      return '<span>' + renderText + '</span>';
    }
    if (markType == 'strikethrough') {
      return '<strike>' + renderText + '</strike>';
    }
    if (markType == 'underline') {
      return '<u>' + renderText + '</u>';
    }
    if (markType == 'italic') {
      return '<em>' + renderText + '</em>';
    }
    if (markType == 'bold') {
      return '<strong>' + renderText + '</strong>';
    }
    {
      return renderText;
    }
  }

  String renderNode(nodeType, Map node_obj, callback) {
    var inner_html = callback(node_obj['children']);
    if (nodeType == 'p') {
      return '<p>' + inner_html + '</p>';
    }
    if (nodeType == 'a') {
      return '<a href=' + node_obj['attrs']['href'] + '>' + inner_html + '</a>';
    }
    if (nodeType == 'img') {
      return '<img src=' + node_obj['attrs']['src'] + ' />' + inner_html + '';
    }
    if (nodeType == 'embed') {
      return '<iframe src=' +
          node_obj['attrs']['src'] +
          '>' +
          inner_html +
          '</iframe>';
    }
    if (nodeType == 'h1') {
      return '<h1>' + inner_html + '</h1>';
    }
    if (nodeType == 'h2') {
      return '<h2>' + inner_html + '</h2>';
    }
    if (nodeType == 'h3') {
      return '<h3>' + inner_html + '</h3>';
    }
    if (nodeType == 'h4') {
      return '<h4>' + inner_html + '</h4>';
    }
    if (nodeType == 'h5') {
      return '<h5>' + inner_html + '</h5>';
    }
    if (nodeType == 'h6') {
      return '<h6>' + inner_html + '</h6>';
    }
    if (nodeType == 'ol') {
      return '<ol>' + inner_html + '</ol>';
    }
    if (nodeType == 'ul') {
      return '<ul>' + inner_html + '</ul>';
    }
    if (nodeType == 'li') {
      return '<li>' + inner_html + '</li>';
    }
    if (nodeType == 'hr') {
      return '<hr />';
    }
    if (nodeType == 'table') {
      return '<table>' + inner_html + '</table>';
    }
    if (nodeType == 'thead') {
      return '<thead>' + inner_html + '</thead>';
    }
    if (nodeType == 'tbody') {
      return '<tbody>' + inner_html + '</tbody>';
    }
    if (nodeType == 'tfoot') {
      return '<tfoot>' + inner_html + '</tfoot>';
    }
    if (nodeType == 'tr') {
      return '<tr>' + inner_html + '</tr>';
    }
    if (nodeType == 'th') {
      return '<th>' + inner_html + '</th>';
    }
    if (nodeType == 'td') {
      return '<td>' + inner_html + '</td>';
    }
    if (nodeType == 'blockquote') {
      return '<blockquote>' + inner_html + '</blockquote>';
    }
    if (nodeType == 'code') {
      return '<code>' + inner_html + '</code>';
    }
    if (['doc', 'reference'].contains(nodeType)) {
      return inner_html;
    }
    return inner_html;
  }
}
