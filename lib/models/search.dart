import 'album.dart';
import 'artist.dart';
import 'genre.dart';
import 'parents/model.dart';
import 'song.dart';

class Search extends Model {
  List<Song>? songs;
  List<Artist>? artists;
  List<Album>? albums;
  List<Genre>? genres;

  Search({
    this.songs,
    this.artists,
    this.albums,
    this.genres,
  });

  Search.fromJson(Map<String, dynamic> json) {
    super.fromJson(json);
    songs = listFromJson(json['songs'], 'data', (song) => Song.fromJson(song));
    artists = listFromJson(
        json['artists'], 'data', (artist) => Artist.fromJson(artist));
    albums =
        listFromJson(json['albums'], 'data', (album) => Album.fromJson(album));
    genres =
        listFromJson(json['genres'], 'data', (genre) => Genre.fromJson(genre));
  }

  @override
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['songs'] = songs;
    data['artists'] = artists;
    data['albums'] = albums;
    data['genres'] = genres;
    return data;
  }

  @override
  bool operator ==(Object? other) =>
      identical(this, other) ||
      super == other &&
          other is Search &&
          runtimeType == other.runtimeType &&
          songs == other.songs &&
          artists == other.artists &&
          albums == other.albums &&
          genres == other.genres;

  @override
  int get hashCode =>
      super.hashCode ^
      songs.hashCode ^
      artists.hashCode ^
      albums.hashCode ^
      genres.hashCode;
}
