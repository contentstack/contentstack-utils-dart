import 'package:contentstack_utils/src/embedded/StyleType.dart';

class Metadata {
  String text;
  /* type of embedded object*/
  String itemType;
  /* itemUid of embedded object*/
  String itemUid;
  /* contentTypeUid of embedded object*/
  String contentTypeUid;
  /* styleTypeUid of embedded object*/
  StyleType styleType;
  /* Outer HTML of embedded object*/
  String outerHTML;
  /* attributes of embedded object*/
  //Attributes attributes;

  Metadata(
      {this.text,
      this.itemType,
      this.itemUid,
      this.contentTypeUid,
      this.styleType,
      this.outerHTML});

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

  StyleType get getStyleType {
    return styleType;
  }

  String get getOuterHtml {
    return outerHTML;
  }
}
