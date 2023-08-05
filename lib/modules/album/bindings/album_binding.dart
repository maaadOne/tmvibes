import 'package:get/get.dart';
import '../controllers/albums_controller.dart';
import '../controllers/album_controller.dart';

class AlbumBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<AlbumsController>(
      () => AlbumsController(),
    );
    Get.lazyPut<AlbumController>(
      () => AlbumController(),
    );
  }
}
