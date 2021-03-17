import 'package:contentstack_utils/Utils.dart';

class Option {
  Option.entry(Map entry);

  static String _findTitleOrUid(Map embeddedObject) {
    var _title = '';
    if (embeddedObject.containsKey('title')) {
      _title = embeddedObject['title'];
    } else if (embeddedObject.containsKey('uid')) {
      _title = embeddedObject['uid'];
    }
    return _title;
  }

  static String _findInlineLink(Metadata metadata, Map embeddedObject) {
    var _title = '';
    if (metadata.getText.isNotEmpty) {
      _title = metadata.getText;
    } else if (embeddedObject.containsKey('title')) {
      _title = embeddedObject['title'];
    } else if (embeddedObject.containsKey('uid')) {
      _title = embeddedObject['uid'];
    }
    return _title;
  }

  static String _findInlineUrl(Map embeddedObject) {
    return embeddedObject['url'];
  }

  static String _findDisplayAtrr(Metadata metadata, Map embeddedObject) {
    var _title = '';
    if (metadata.attributes.isNotEmpty) {
      _title = metadata.attributes.toString();
    } else if (embeddedObject.containsKey('title')) {
      _title = embeddedObject['title'];
    } else if (embeddedObject.containsKey('filename')) {
      _title = embeddedObject['filename'];
    } else if (embeddedObject.containsKey('uid')) {
      _title = embeddedObject['uid'];
    }
    return _title;
  }

  String renderOption(Map embeddedObject, Metadata metadata) {
    if (metadata.styleType == 'block') {
      return "<div><p>$_findTitleOrUid(embeddedObject)</p><p>Content type: <span>${embeddedObject['_content_type_uid']}</span></p></div>";
    } else if (metadata.styleType == 'inline') {
      return '<span>$_findTitleOrUid(embeddedObject)</span>';
    } else if (metadata.styleType == 'link') {
      return '<a href=$_findInlineUrl(embeddedObject)>$_findInlineLink(metadata, embeddedObject)</a>';
    } else if (metadata.styleType == 'display') {
      return '<img src=${_findInlineUrl(embeddedObject)} alt=$_findDisplayAtrr(metadata, embeddedObject) />';
    } else if (metadata.styleType == 'download') {
      return '<a href=${_findInlineUrl(embeddedObject)} alt=$_findDisplayAtrr(metadata, embeddedObject) </a>';
    }
    return '';
  }
}
