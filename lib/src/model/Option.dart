import 'package:contentstack_utils/contentstack_utils.dart';

class Option {
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
    } else if (metadata.styleType == 'inline') {
      return '<span>$_findTitleOrUid(embeddedObject)</span>';
    } else if (metadata.styleType == 'link') {
      return '<a href=$_findInlineUrl(embeddedObject)>$_findInlineLink(metadata, embeddedObject)</a>';
    } else if (metadata.styleType == 'display') {
      return '<img src=${_findInlineUrl(obj)} alt=$_findDisplayAtrr(metadata, embeddedObject) />';
    } else if (metadata.styleType == 'download') {
      return '<a href=${_findInlineUrl(obj)} alt=$_findDisplayAtrr(metadata, embeddedObject) </a>';
    }
    return '';
  }
}
