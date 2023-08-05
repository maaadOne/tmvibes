import 'package:get/get.dart';

import '../models/genre.dart';
import '../providers/back_end_provider.dart';

class GenreRepository {
  BackEndApiClient? _backEndApiClient;

  GenreRepository() {
    _backEndApiClient = Get.find<BackEndApiClient>();
  }

  Future<List<Genre>> getGenres(int page) {
    return _backEndApiClient!.getGenre(page);
  }
}
