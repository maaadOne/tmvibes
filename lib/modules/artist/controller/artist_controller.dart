import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../../common/ui.dart';
import '../../../models/album.dart';
import '../../../models/artist.dart';
import '../../../models/song.dart';
import '../../../repositories/album_repository.dart';
import '../../../repositories/song_repository.dart';

class ArtistController extends GetxController {
  final songs = <Song>[].obs;
  final albums = <Album>[].obs;
  ScrollController scrollController = ScrollController();
  final page = 0.obs;
  final isLoading = true.obs;
  final isDone = false.obs;
  final artist = Artist().obs;
  SongRepository? songRepository;
  AlbumRepository? albumRepository;

  ArtistController() {
    songRepository = SongRepository();
    albumRepository = AlbumRepository();
  }

  @override
  void onInit() {
    var arguments = Get.arguments as Map<String, dynamic>;
    artist.value = arguments['artist'] as Artist;

    super.onInit();
  }

  @override
  void onReady() async {
    await refreshArtistSongs();
    await getArtistAlbums();
    scrollController.addListener(() {
      if (scrollController.position.pixels ==
              scrollController.position.maxScrollExtent &&
          !isDone.value) {
        getArtistSongs();
      }
    });
    super.onReady();
  }

  @override
  void onClose() {
    scrollController.dispose();
  }

  Future refreshArtistSongs({bool showMessage = false}) async {
    songs.clear();
    await getArtistSongs();
    if (showMessage) {
      Get.showSnackbar(
          Ui.successSnackBar(message: "Sahypa üstünlikli ýüklenildi".tr));
    }
  }

  Future getArtistAlbums() async {
    var index = 1;
    while (true) {
      List<Album> _albums =
          await albumRepository!.getArtistAlbums(artist.value.id!, index);
      if (_albums.isEmpty) {
        break;
      } else {
        albums.addAll(_albums);
        if (_albums.length < 24) {
          break;
        }
      }

      index++;
    }
  }

  Future getArtistSongs() async {
    try {
      isLoading.value = true;
      isDone.value = false;
      page.value++;

      List<Song> _songs = [];

      _songs =
          await songRepository!.getArtistSongs(artist.value.id!, page.value);

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
