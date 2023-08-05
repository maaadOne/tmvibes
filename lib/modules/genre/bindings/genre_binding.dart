import 'package:get/get.dart';
import '../controller/genres_controller.dart';
import '../controller/genre_controller.dart';

class GenreBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<GenresController>(
      () => GenresController(),
    );
    Get.lazyPut<GenreController>(
      () => GenreController(),
    );
  }
}
