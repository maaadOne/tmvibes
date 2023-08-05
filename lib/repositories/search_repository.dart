import 'package:get/get.dart';
import '../providers/back_end_provider.dart';

class SearchRepository {
  BackEndApiClient? _backEndApiClient;

  SearchRepository() {
    _backEndApiClient = Get.find<BackEndApiClient>();
  }

  Future search(String mask) {
    return _backEndApiClient!.search(mask);
  }
}
