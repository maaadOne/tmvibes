import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../common/ui.dart';
import '../../../models/song.dart';
import '../../../repositories/song_repository.dart';

class SongsController extends GetxController {
  SongRepository? songRepository;
  final songs = <Song>[].obs;
  ScrollController scrollController = ScrollController();
  final page = 0.obs;
  final isLoading = true.obs;
  final isDone = false.obs;

  SongsController() {
    songRepository = SongRepository();
  }

  @override
  Future<void> onInit() async {
    await refreshSongs();
    scrollController.addListener(() {
      if (scrollController.position.pixels ==
              scrollController.position.maxScrollExtent &&
          !isDone.value) {
        getSongs();
      }
    });
    super.onInit();
  }

  @override
  void onClose() {
    scrollController.dispose();
  }

  Future refreshSongs({bool? showMessage}) async {
    songs.clear();
    await getSongs();
    if (showMessage == true) {
      Get.showSnackbar(
          Ui.successSnackBar(message: "Sahypa üstünlikli ýüklenildi".tr));
    }
  }

  Future getSongs() async {
    try {
      isLoading.value = true;
      isDone.value = false;
      page.value++;

      List<Song> _songs = [];

      _songs = await songRepository!.getSongs(page.value);

      if (_songs.isNotEmpty) {
        songs.addAll(_songs);
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
