import 'dart:collection';

import 'package:html/dom.dart';

class Metadata {
  String text;
  String itemType;
  String itemUid;
  String contentTypeUid;
  String styleType;
  String outerHTML;
  LinkedHashMap<dynamic, String> attributes;

  String get getText => text;

  String get getItemType => itemType;

  String get getItemUid => itemUid;

  String get getContentTypeUid => contentTypeUid;

  String get getStyleType => styleType;

  String get getOuterHTML => outerHTML;

  LinkedHashMap<dynamic, String> get getAttributes => attributes;

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
}
