import 'package:get/get.dart';

import '../models/song.dart';
import '../providers/back_end_provider.dart';

class SongRepository {
  BackEndApiClient? _backEndApiClient;

  SongRepository() {
    _backEndApiClient = Get.find<BackEndApiClient>();
  }

  Future<List<Song>> getSongs(int page) {
    return _backEndApiClient!.getSongs(page);
  }

  Future<List<Song>> getArtistSongs(int artistID, int page) {
    return _backEndApiClient!.getArtistSongs(page, artistID);
  }

  Future<List<Song>> getAlbumSongs(int albumId, int page) {
    return _backEndApiClient!.getAlbumSongs(page, albumId);
  }

  Future<List<Song>> getPlayListSongs(int playListID, int page) {
    return _backEndApiClient!.getPlayListSongs(page, playListID);
  }

  Future<List<Song>> getGenreSongs(int genreID, int page) {
    return _backEndApiClient!.getGenreSongs(page, genreID);
  }

  Future<List<Song>> getPopularSongs(int typeID, int page) {
    return _backEndApiClient!.getTopSongs(page, typeID);
  }
}
