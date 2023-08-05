import 'package:get/get.dart';
import '../../album/controllers/albums_controller.dart';
import '../../artist/controller/artists_controller.dart';
import '../../genre/controller/genres_controller.dart';
import '../../home/controller/home_controller.dart';
import '../controllers/root_controller.dart';

class RootBinding extends Bindings {
  @override
  void dependencies() {
    Get.put(RootController(), permanent: true);
    Get.put(HomeController(), permanent: true);
    Get.lazyPut<ArtistsController>(() => ArtistsController());
    Get.lazyPut<AlbumsController>(() => AlbumsController());
    Get.lazyPut<GenresController>(() => GenresController());
  }
}
