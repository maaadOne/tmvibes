import 'package:get/get.dart';

import '../models/album.dart';
import '../providers/back_end_provider.dart';

class AlbumRepository {
  BackEndApiClient? _backEndApiClient;

  AlbumRepository() {
    _backEndApiClient = Get.find<BackEndApiClient>();
  }

  Future<List<Album>> getAlbums(int page) {
    return _backEndApiClient!.getAlbums(page);
  }

  Future<List<Album>> getArtistAlbums(int artistId, int page) {
    return _backEndApiClient!.getArtistAlbums(page, artistId);
  }
}
