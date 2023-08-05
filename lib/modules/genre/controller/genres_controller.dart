import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../common/ui.dart';
import '../../../models/genre.dart';
import '../../../repositories/genre_repository.dart';
import '../../../services/ip_service.dart';

class GenresController extends GetxController {
  GenreRepository? genreRepository;
  final ipService = Get.find<IpService>();
  final genres = <Genre>[].obs;
  ScrollController scrollController = ScrollController();
  final page = 0.obs;
  final isLoading = true.obs;
  final isDone = false.obs;

  GenresController() {
    genreRepository = GenreRepository();
  }

  @override
  Future<void> onInit() async {
    await refreshGenres();
    scrollController.addListener(() {
      if (scrollController.position.pixels ==
              scrollController.position.maxScrollExtent &&
          !isDone.value) {
        getGenres();
      }
    });
    super.onInit();
  }

  @override
  void onClose() {
    scrollController.dispose();
  }

  Future refreshGenres({bool? showMessage}) async {
    genres.clear();
    await getGenres();
    if (showMessage == true) {
      Get.showSnackbar(
          Ui.successSnackBar(message: "Sahypa üstünlikli ýüklenildi".tr));
    }
  }

  Future getGenres() async {
    try {
      isLoading.value = true;
      isDone.value = false;
      page.value++;
      if (ipService.isTurkmen) {
        List<Genre> _genres = [];

        _genres = await genreRepository!.getGenres(page.value);

        if (_genres.isNotEmpty) {
          genres.addAll(_genres);
        } else {
          isDone.value = true;
        }
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
