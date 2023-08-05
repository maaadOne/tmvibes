import 'package:get/get.dart';
import '../controller/songs_controller.dart';

class AlbumBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<SongsController>(
      () => SongsController(),
    );
  }
}
