import 'package:get/get.dart';
import 'package:just_audio/just_audio.dart';
import '../../../../common/ui.dart';
import '../../../models/album.dart';
import '../../../models/song.dart';
import '../../../repositories/song_repository.dart';
import '../../root/controllers/root_controller.dart';

class AlbumController extends GetxController {
  AudioPlayer audioPlayer = Get.find<RootController>().audioPlayer;
  final songs = <Song>[].obs;
  final album = Album().obs;
  final isThisAlbum = false.obs;
  final isPlayed = false.obs;
  final isLoading = true.obs;
  SongRepository? songRepository;

  AlbumController() {
    songRepository = SongRepository();
  }

  @override
  void onInit() {
    var arguments = Get.arguments as Map<String, dynamic>;
    album.value = arguments['album'] as Album;
    if (audioPlayer.processingState != ProcessingState.completed) {
      if (audioPlayer.sequenceState != null) {
        int? currentPlayedAlbumId = audioPlayer
            .sequenceState!.currentSource!.tag.extras["album_id"] as int?;
        if (currentPlayedAlbumId != null &&
            currentPlayedAlbumId == album.value.id) {
          isThisAlbum.value = true;
          isPlayed.value = true;
        }
      }
    }
    super.onInit();
  }

  @override
  void onReady() async {
    await refreshAlbumSongs();
    super.onReady();
  }

  Future refreshAlbumSongs({bool showMessage = false}) async {
    songs.clear();
    await getAlbumSongs();
    if (showMessage) {
      Get.showSnackbar(
          Ui.successSnackBar(message: "Sahypa üstünlikli ýüklenildi".tr));
    }
  }

  Future<void> puseMedia() async {
    isPlayed.value = false;
    await audioPlayer.pause();
  }

  Future<void> playMedia() async {
    isPlayed.value = true;
    await audioPlayer.play();
  }

  void chageCurrentAlbum() {
    isThisAlbum.value = true;
    isPlayed.value = true;
  }

  Future getAlbumSongs() async {
    try {
      int index = 1;
      while (true) {
        List<Song> _songs = [];

        _songs = await songRepository!.getAlbumSongs(album.value.id!, index);
        if (_songs.isEmpty) {
          break;
        } else {
          songs.addAll(_songs);
          if (_songs.length < 50) {
            break;
          }
        }

        index++;
      }
    } catch (e) {
      Get.showSnackbar(Ui.errorSnackBar(message: "Ýalňyşlyk ýüze çykdy".tr));
    } finally {
      isLoading.value = false;
    }
  }
}
