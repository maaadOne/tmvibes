import 'package:get/get.dart';

import '../services/global_service.dart';
import 'parents/model.dart';

class Media extends Model {
  String? name;
  String? url;
  String? thumb;
  String? icon;
  String? size;
  String? mime;
  String? preview;

  Media({String? id, String? url, String? thumb, String? icon}) {
    this.url =
        url ?? "${Get.find<GlobalService>().baseUrl}images/image_default.png";
    this.thumb =
        thumb ?? "${Get.find<GlobalService>().baseUrl}images/image_default.png";
    this.icon =
        icon ?? "${Get.find<GlobalService>().baseUrl}images/image_default.png";
  }

  Media.fromJson(Map<String, dynamic> jsonMap) {
    name = jsonMap['name'];
    url = jsonMap['url'];
    thumb = jsonMap['thumb'];
    icon = jsonMap['icon'];
    size = jsonMap['formatted_size'];
    mime = jsonMap['mime'];
    preview = jsonMap['preview'];
  }

  @override
  Map<String, dynamic> toJson() {
    var map = <String, dynamic>{};
    map["id"] = id;
    map["name"] = name;
    map["url"] = url;
    map["thumb"] = thumb;
    map["icon"] = icon;
    map["formatted_size"] = size;
    map["mime"] = mime;
    map["preview"] = preview;
    return map;
  }

  @override
  bool operator ==(Object? other) =>
      identical(this, other) ||
      super == other &&
          other is Media &&
          runtimeType == other.runtimeType &&
          id == other.id &&
          name == other.name &&
          url == other.url &&
          thumb == other.thumb &&
          icon == other.icon &&
          size == other.size &&
          mime == other.mime &&
          preview == other.preview;

  @override
  int get hashCode =>
      super.hashCode ^
      id.hashCode ^
      name.hashCode ^
      url.hashCode ^
      thumb.hashCode ^
      icon.hashCode ^
      size.hashCode ^
      mime.hashCode ^
      preview.hashCode;
}
