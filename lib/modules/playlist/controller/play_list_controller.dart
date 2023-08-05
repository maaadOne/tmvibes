import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../../common/ui.dart';
import '../../../models/play_list.dart';
import '../../../models/song.dart';
import '../../../repositories/song_repository.dart';

class PlayListController extends GetxController {
  final songs = <Song>[].obs;
  ScrollController scrollController = ScrollController();
  final page = 0.obs;
  final isLoading = true.obs;
  final isDone = false.obs;
  final playList = PlayList().obs;
  SongRepository? songRepository;

  PlayListController() {
    songRepository = SongRepository();
  }

  // Tdob12345!

  @override
  void onInit() {
    var arguments = Get.arguments as Map<String, dynamic>;
    playList.value = arguments['playList'] as PlayList;
    super.onInit();
  }

  @override
  void onReady() async {
    await refreshAlbumSongs();
    scrollController.addListener(() {
      if (scrollController.position.pixels ==
              scrollController.position.maxScrollExtent &&
          !isDone.value) {
        getPlayListSongs();
      }
    });
    super.onReady();
  }

  @override
  void onClose() {
    scrollController.dispose();
  }

  Future refreshAlbumSongs({bool showMessage = false}) async {
    songs.clear();
    await getPlayListSongs();
    if (showMessage) {
      Get.showSnackbar(
          Ui.successSnackBar(message: "Sahypa üstünlikli ýüklenildi".tr));
    }
  }

  Future getPlayListSongs() async {
    try {
      isLoading.value = true;
      isDone.value = false;
      page.value++;

      List<Song> _songs = [];

      _songs = await songRepository!
          .getPlayListSongs(playList.value.id!, page.value);

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
