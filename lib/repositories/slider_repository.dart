import 'package:get/get.dart';
import '../models/slide_model.dart';
import '../providers/back_end_provider.dart';

class SliderRepository {
  BackEndApiClient? _backEndApiClient;

  SliderRepository() {
    _backEndApiClient = Get.find<BackEndApiClient>();
  }

  Future<List<Slide>> getSliders() {
    return _backEndApiClient!.getHomeSlider();
  }
}
