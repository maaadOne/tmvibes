import 'package:get/get.dart';

import '../models/play_list.dart';
import '../providers/back_end_provider.dart';

class PlayListRepository {
  BackEndApiClient? _backEndApiClient;

  PlayListRepository() {
    _backEndApiClient = Get.find<BackEndApiClient>();
  }

  Future<List<PlayList>> getPlayLists(int page) {
    return _backEndApiClient!.getPlayLists(page);
  }
}
