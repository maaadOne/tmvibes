import 'package:get/get.dart';
import '../controller/artists_controller.dart';
import '../controller/artist_controller.dart';

class ArtistBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<ArtistsController>(
      () => ArtistsController(),
    );
    Get.lazyPut<ArtistController>(
      () => ArtistController(),
    );
  }
}
