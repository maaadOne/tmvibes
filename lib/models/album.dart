import 'parents/model.dart';

class Album extends Model {
  int? id;
  String? name;
  String? imageUrl;
  String? artistName;
  int? artistId;
  int? songCount;
  String? duration;

  Album(
      {this.id,
      this.name,
      this.imageUrl,
      this.artistName,
      this.artistId,
      this.songCount,
      this.duration});

  Album.fromJson(Map<String, dynamic> json) {
    super.fromJson(json);
    artistName = stringFromJson(json, 'artistName');
    name = stringFromJson(json, 'name');
    imageUrl = stringFromJson(json, 'imageUrl');
    duration = stringFromJson(json, 'duration');
    artistId = intFromJson(json, "artistId");
    songCount = intFromJson(json, "songCount");
  }

  @override
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['artistName'] = artistName;
    data['artistId'] = artistId;
    data['songCount'] = songCount;
    data['duration'] = duration;
    data['name'] = name;
    data['imageUrl'] = imageUrl;
    return data;
  }

  @override
  bool operator ==(Object? other) =>
      identical(this, other) ||
      super == other &&
          other is Album &&
          runtimeType == other.runtimeType &&
          id == other.id &&
          artistName == other.artistName &&
          artistId == other.artistId &&
          songCount == other.songCount &&
          duration == other.duration &&
          name == other.name &&
          imageUrl == other.imageUrl;

  @override
  int get hashCode =>
      super.hashCode ^
      id.hashCode ^
      artistName.hashCode ^
      imageUrl.hashCode ^
      artistId.hashCode ^
      songCount.hashCode ^
      duration.hashCode ^
      name.hashCode;
}
