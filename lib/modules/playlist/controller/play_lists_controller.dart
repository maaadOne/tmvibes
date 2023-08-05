import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../common/ui.dart';
import '../../../models/play_list.dart';
import '../../../repositories/play_list_repository.dart';

class PlayListsController extends GetxController {
  PlayListRepository? playListRepository;
  final playLists = <PlayList>[].obs;
  ScrollController scrollController = ScrollController();
  final page = 0.obs;
  final isLoading = true.obs;
  final isDone = false.obs;

  PlayListsController() {
    playListRepository = PlayListRepository();
  }

  @override
  Future<void> onInit() async {
    await refreshPlayLists();
    scrollController.addListener(() {
      if (scrollController.position.pixels ==
              scrollController.position.maxScrollExtent &&
          !isDone.value) {
        getPlayLists();
      }
    });
    super.onInit();
  }

  @override
  void onClose() {
    scrollController.dispose();
  }

  Future refreshPlayLists({bool? showMessage}) async {
    playLists.clear();
    await getPlayLists();
    if (showMessage == true) {
      Get.showSnackbar(
          Ui.successSnackBar(message: "Sahypa üstünlikli ýüklenildi".tr));
    }
  }

  Future getPlayLists() async {
    try {
      isLoading.value = true;
      isDone.value = false;
      page.value++;

      List<PlayList> _playLists = [];

      _playLists = await playListRepository!.getPlayLists(page.value);

      if (_playLists.isNotEmpty) {
        playLists.addAll(_playLists);
      } else {
        isDone.value = true;
      }
    } catch (e) {
      Get.showSnackbar(Ui.errorSnackBar(message: "Ýalňyşlyk ýüze çykdy".tr));
    } finally {
      isLoading.value = false;
    }
  }
}
