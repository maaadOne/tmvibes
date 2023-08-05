import 'package:get/get.dart';

import '../models/artist.dart';
import '../providers/back_end_provider.dart';

class ArtistRepository {
  BackEndApiClient? _backEndApiClient;

  ArtistRepository() {
    _backEndApiClient = Get.find<BackEndApiClient>();
  }

  Future<List<Artist>> getArtists(int typeId, int page) {
    return _backEndApiClient!.getArtists(page, typeId);
  }
}
