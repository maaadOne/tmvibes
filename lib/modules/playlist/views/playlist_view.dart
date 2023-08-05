import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:nb_utils/nb_utils.dart';
import '../../../routes/app_routes.dart';
import '../../../utils/helper_widget.dart';
import '../../../utils/colors.dart';
import '../controller/play_list_controller.dart';

class PlaylistView extends GetView<PlayListController> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(controller.playList.value.name!).center(),
        backgroundColor: mpAppBackGroundColor,
        iconTheme: const IconThemeData(color: Colors.white),
        actions: [
          searchIconWidget(
            onPressed: () {
              Get.toNamed(Routes.search);
            },
          ),
        ],
      ),
    );
  }
}
