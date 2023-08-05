import 'parents/model.dart';

class PlayList extends Model {
  int? id;
  String? code;
  String? name;
  String? imageUrl;
  int? songCount;
  String? duration;
  bool? statShow;

  PlayList({
    this.id,
    this.code,
    this.name,
    this.imageUrl,
    this.songCount,
    this.duration,
    this.statShow,
  });

  PlayList.fromJson(Map<String, dynamic> json) {
    super.fromJson(json);
    code = stringFromJson(json, 'code');
    name = stringFromJson(json, 'name');
    imageUrl = stringFromJson(json, 'imageUrl');
    songCount = intFromJson(json, "songCount");
    duration = stringFromJson(json, 'duration');
    statShow = boolFromJson(json, "statShow");
  }

  @override
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['code'] = code;
    data['name'] = name;
    data['imageUrl'] = imageUrl;
    data['songCount'] = songCount;
    data['duration'] = duration;
    data['statShow'] = statShow;
    return data;
  }

  @override
  bool operator ==(Object? other) =>
      identical(this, other) ||
      super == other &&
          other is PlayList &&
          runtimeType == other.runtimeType &&
          id == other.id &&
          code == other.code &&
          name == other.name &&
          songCount == other.songCount &&
          duration == other.duration &&
          statShow == other.statShow &&
          imageUrl == other.imageUrl;

  @override
  int get hashCode =>
      super.hashCode ^
      id.hashCode ^
      code.hashCode ^
      imageUrl.hashCode ^
      songCount.hashCode ^
      duration.hashCode ^
      statShow.hashCode ^
      name.hashCode;
}
