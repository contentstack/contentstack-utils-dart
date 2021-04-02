import 'dart:collection';

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

  // Returns text
  String get getText {
    return text;
  }

  // Returns ItemType
  String get getItemType {
    return itemType;
  }

  // Returns ItemUid
  String get getItemUid {
    return itemUid;
  }

  // Returns contentTypeUid
  String get getContentTypeUid {
    return contentTypeUid;
  }

  // Return styleType
  String get getStyleType {
    return styleType;
  }

  //Return outerHTML
  String get getOuterHtml {
    return outerHTML;
  }
}
