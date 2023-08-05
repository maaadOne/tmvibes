import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../../common/ui.dart';
import '../../../models/genre.dart';
import '../../../models/song.dart';
import '../../../repositories/song_repository.dart';

class GenreController extends GetxController {
  final songs = <Song>[].obs;
  ScrollController scrollController = ScrollController();
  final page = 0.obs;
  final isLoading = true.obs;
  final isDone = false.obs;
  final genre = Genre().obs;
  SongRepository? songRepository;

  GenreController() {
    songRepository = SongRepository();
  }

  @override
  void onInit() {
    var arguments = Get.arguments as Map<String, dynamic>;
    genre.value = arguments['genre'] as Genre;
    super.onInit();
  }

  @override
  void onReady() async {
    await refreshGenreSongs();
    scrollController.addListener(() {
      if (scrollController.position.pixels ==
              scrollController.position.maxScrollExtent &&
          !isDone.value) {
        getGenreSongs();
      }
    });
    super.onReady();
  }

  @override
  void onClose() {
    scrollController.dispose();
  }

  Future refreshGenreSongs({bool showMessage = false}) async {
    songs.clear();
    await getGenreSongs();
    if (showMessage) {
      Get.showSnackbar(
          Ui.successSnackBar(message: "Sahypa üstünlikli ýüklenildi".tr));
    }
  }

  Future getGenreSongs() async {
    try {
      isLoading.value = true;
      isDone.value = false;
      page.value++;

      List<Song> _songs = [];

      _songs = await songRepository!.getGenreSongs(genre.value.id!, page.value);

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
