import 'dart:collection';
import 'dart:html';

import 'package:html/dom.dart';

class Metadata {
  String text;
  /* type of embedded object*/
  String itemType;
  /* itemUid of embedded object*/
  String itemUid;
  /* contentTypeUid of embedded object*/
  String contentTypeUid;
  /* styleTypeUid of embedded object*/
  String styleType;
  /* Outer HTML of embedded object*/
  String outerHTML;
  /* attributes of embedded object*/
  LinkedHashMap<dynamic, String> attributes;

  Metadata.element(Element element) {
    text = element.text;
    itemType = element.attributes['type'];
    itemUid = element.attributes['data-sys-asset-uid'] ??
        element.attributes['data-sys-entry-uid'];
    contentTypeUid = element.attributes['data-sys-content-type-uid'];
    styleType = element.attributes['sys-style-type'];
    outerHTML = element.outerHtml;
    attributes = element.attributes;
  }

  String get getText {
    return text;
  }

  String get getItemType {
    return itemType;
  }

  String get getItemUid {
    return itemUid;
  }

  String get getContentTypeUid {
    return contentTypeUid;
  }

  String get getStyleType {
    return styleType;
  }

  String get getOuterHtml {
    return outerHTML;
  }
}
