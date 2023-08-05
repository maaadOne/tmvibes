import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../common/ui.dart';
import '../../../models/album.dart';
import '../../../repositories/album_repository.dart';
import '../../../services/ip_service.dart';

class AlbumsController extends GetxController {
  AlbumRepository? albumRepository;
  final ipService = Get.find<IpService>();
  final albums = <Album>[].obs;
  ScrollController scrollController = ScrollController();
  final page = 0.obs;
  final isLoading = true.obs;
  final isDone = false.obs;

  AlbumsController() {
    albumRepository = AlbumRepository();
  }

  @override
  Future<void> onInit() async {
    await refreshAlbums();
    scrollController.addListener(() {
      if (scrollController.position.pixels ==
              scrollController.position.maxScrollExtent &&
          !isDone.value) {
        getAlbums();
      }
    });
    super.onInit();
  }

  @override
  void onClose() {
    scrollController.dispose();
  }

  Future refreshAlbums({bool? showMessage}) async {
    albums.clear();
    await getAlbums();
    if (showMessage == true) {
      Get.showSnackbar(
          Ui.successSnackBar(message: "Sahypa üstünlikli ýüklenildi".tr));
    }
  }

  Future getAlbums() async {
    try {
      isLoading.value = true;
      isDone.value = false;
      page.value++;
      if (ipService.isTurkmen) {
        List<Album> _albums = [];

        _albums = await albumRepository!.getAlbums(page.value);

        if (_albums.isNotEmpty) {
          albums.addAll(_albums);
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
