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
    } else if (obj.containsKey('system')) {
      Map system = obj['system'];
      if (system.containsKey('uid')) {
        _title = system['uid'];
      }
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
    } else if (obj.containsKey('system')) {
      Map system = obj['system'];
      if (system.containsKey('uid')) {
        _title = system['uid'];
      }
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
    } else if (obj.containsKey('system')) {
      Map system = obj['system'];
      if (system.containsKey('uid')) {
        _title = system['uid'];
      }
    }
    return _title;
  }

  String renderOption(Map obj, Metadata metadata) {
    var style = metadata.styleType;
    switch (style) {
      case 'block':
        var titlOrUid = _findTitleOrUid(obj);
        var _content_type_uid =
            obj['_content_type_uid'] ?? obj['system']['content_type_uid'];
        return '<div><p>$titlOrUid</p><p>Content type: <span>$_content_type_uid</span></p></div>';
      case 'inline':
        var displyPlayers = _findInlineLink(metadata, obj);
        return '<span>$displyPlayers</span>';
      case 'link':
        var displyPlayers = _findDisplayAtrr(metadata, obj);
        var inlineUrl = _findInlineUrl(obj);
        return '<a href=$inlineUrl>$displyPlayers</a>';
      case 'display':
        var _inlineUrl = _findInlineUrl(obj);
        var displyPlayers = _findDisplayAtrr(metadata, obj);
        return '<img src="$_inlineUrl" alt=$displyPlayers />';
      case 'download':
        var _inlineUrl = _findInlineUrl(obj);
        var displyPlayers = _findDisplayAtrr(metadata, obj);
        return '<a href=$_inlineUrl alt=$displyPlayers </a>';
      default:
        return '';
    }
  }

  String renderMark(String markType, String renderText) {
    switch (markType) {
      case 'superscript':
        return '<sup>' + renderText + '</sup>';
      case 'subscript':
        return '<sub>' + renderText + '</sub>';
      case 'inlineCode':
        return '<span>' + renderText + '</span>';
      case 'strikethrough':
        return '<strike>' + renderText + '</strike>';
      case 'underline':
        return '<u>' + renderText + '</u>';
      case 'italic':
        return '<em>' + renderText + '</em>';
      case 'bold':
        return '<strong>' + renderText + '</strong>';
      default:
        return renderText;
    }
  }

  String renderNode(nodeType, Map node_obj, callback) {
    var inner_html = callback(node_obj['children']);
    switch (nodeType) {
      case 'p':
        return '<p>' + inner_html + '</p>';
      case 'a':
        return '<a href="' +
            node_obj['attrs']['href'] +
            '">' +
            inner_html +
            '</a>';
      case 'img':
        return '<img src="' +
            node_obj['attrs']['src'] +
            '"/>' +
            inner_html +
            '';
      case 'embed':
        return '<iframe src="' +
            node_obj['attrs']['src'] +
            '">' +
            inner_html +
            '</iframe>';
      case 'h1':
        return '<h1>' + inner_html + '</h1>';
      case 'h2':
        return '<h2>' + inner_html + '</h2>';
      case 'h3':
        return '<h3>' + inner_html + '</h3>';
      case 'h4':
        return '<h4>' + inner_html + '</h4>';
      case 'h5':
        return '<h5>' + inner_html + '</h5>';
      case 'h6':
        return '<h6>' + inner_html + '</h6>';
      case 'ol':
        return '<ol>' + inner_html + '</ol>';
      case 'ul':
        return '<ul>' + inner_html + '</ul>';
      case 'li':
        return '<li>' + inner_html + '</li>';
      case 'hr':
        return '<hr />';
      case 'table':
        return '<table>' + inner_html + '</table>';
      case 'thead':
        return '<thead>' + inner_html + '</thead>';
      case 'tbody':
        return '<tbody>' + inner_html + '</tbody>';
      case 'tfoot':
        return '<tfoot>' + inner_html + '</tfoot>';
      case 'tr':
        return '<tr>' + inner_html + '</tr>';
      case 'th':
        return '<th>' + inner_html + '</th>';
      case 'td':
        return '<td>' + inner_html + '</td>';
      case 'blockquote':
        return '<blockquote>' + inner_html + '</blockquote>';
      case 'code':
        return '<code>' + inner_html + '</code>';
      default:
        return '<doc>' + inner_html + '</code>';
    }
  }
}
