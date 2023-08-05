import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../common/ui.dart';
import '../../../models/artist.dart';
import '../../../repositories/artist_repository.dart';
import '../../../services/ip_service.dart';

class ArtistsController extends GetxController {
  ArtistRepository? artistRepository;
  final ipService = Get.find<IpService>();
  final artists = <Artist>[].obs;
  ScrollController scrollController = ScrollController();
  final page = 0.obs;
  final isLoading = true.obs;
  final isDone = false.obs;
  final isDoneTm = false.obs;
  final isDoneOther = false.obs;

  ArtistsController() {
    artistRepository = ArtistRepository();
  }

  @override
  Future<void> onInit() async {
    await refreshArtists();
    scrollController.addListener(() {
      if (scrollController.position.pixels ==
              scrollController.position.maxScrollExtent &&
          !isDone.value) {
        getArtists();
      }
    });
    super.onInit();
  }

  @override
  void onClose() {
    scrollController.dispose();
  }

  Future refreshArtists({bool? showMessage}) async {
    artists.clear();
    await getArtists();
    if (showMessage == true) {
      Get.showSnackbar(
          Ui.successSnackBar(message: "Sahypa üstünlikli ýüklenildi".tr));
    }
  }

  Future getArtists() async {
    try {
      isLoading.value = true;
      isDone.value = false;
      page.value++;

      if (!isDoneTm.value) {
        List<Artist> _artists = [];
        _artists = await artistRepository!.getArtists(1, page.value);
        if (_artists.isNotEmpty) {
          artists.addAll(_artists);
        } else {
          isDoneTm.value = true;
        }
      }

      if (ipService.isTurkmen) {
        List<Artist> _artists_2 = [];
        _artists_2 = await artistRepository!.getArtists(2, page.value);
        if (_artists_2.isNotEmpty) {
          artists.addAll(_artists_2);
        } else {
          isDoneOther.value = true;
        }
      } else {
        isDoneOther.value = true;
      }

      if (isDoneTm.value && isDoneOther.value) {
        isDone.value = true;
      }
    } catch (e) {
      Get.showSnackbar(Ui.errorSnackBar(message: "Ýalňyşlyk ýüze çykdy".tr));
    } finally {
      isLoading.value = false;
    }
  }
}
