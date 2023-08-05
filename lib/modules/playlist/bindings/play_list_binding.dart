import 'package:get/get.dart';
import '../controller/play_lists_controller.dart';
import '../controller/play_list_controller.dart';

class PlayListBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<PlayListsController>(
      () => PlayListsController(),
    );
    Get.lazyPut<PlayListController>(
      () => PlayListController(),
    );
  }
}
