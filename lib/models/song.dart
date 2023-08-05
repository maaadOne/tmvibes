import 'parents/model.dart';

class Song extends Model {
  int? id;
  String? name;
  String? duration;
  String? artist;
  String? artistCode;
  int? artistId;
  String? url;
  String? coverArtUrl;
  String? date;
  int? playlistId;
  int? albumId;

  Song({
    this.id,
    this.name,
    this.duration,
    this.artist,
    this.artistCode,
    this.artistId,
    this.url,
    this.coverArtUrl,
    this.date,
    this.playlistId,
    this.albumId,
  });

  Song.fromJson(Map<String, dynamic> json) {
    super.fromJson(json);
    name = stringFromJson(json, 'name');
    duration = stringFromJson(json, 'duration');
    artist = stringFromJson(json, 'artist');
    artistCode = stringFromJson(json, 'artistCode');
    artistId = intFromJson(json, 'artistId');
    url = stringFromJson(json, 'url');
    coverArtUrl = stringFromJson(json, 'cover_art_url');
    date = stringFromJson(json, 'date');
    playlistId = intFromJson(json, 'playlistId');
    albumId = intFromJson(json, 'albumId');
  }

  @override
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['name'] = name;
    data['duration'] = duration;
    data['artist'] = artist;
    data['artistCode'] = artistCode;
    data['artistId'] = artistId;
    data['url'] = url;
    data['cover_art_url'] = coverArtUrl;
    data['date'] = date;
    data['playlistId'] = playlistId;
    data['albumId'] = albumId;

    return data;
  }

  @override
  bool operator ==(Object? other) =>
      identical(this, other) ||
      super == other &&
          other is Song &&
          runtimeType == other.runtimeType &&
          id == other.id &&
          name == other.name &&
          duration == other.duration &&
          artist == other.artist &&
          artistCode == other.artistCode &&
          artistId == other.artistId &&
          url == other.url &&
          coverArtUrl == other.coverArtUrl &&
          date == other.date &&
          playlistId == other.playlistId &&
          albumId == other.albumId;

  @override
  int get hashCode =>
      super.hashCode ^
      id.hashCode ^
      name.hashCode ^
      duration.hashCode ^
      artist.hashCode ^
      artistCode.hashCode ^
      artistId.hashCode ^
      url.hashCode ^
      coverArtUrl.hashCode ^
      date.hashCode ^
      playlistId.hashCode ^
      albumId.hashCode;
}

List<Map<String, dynamic>> songListToJson(List<Song> models) =>
    models.map((x) => x.toJson()).toList();
