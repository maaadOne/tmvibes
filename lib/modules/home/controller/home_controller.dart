import 'dart:async';
import 'package:get/get.dart';
import '../../../../common/ui.dart';
import '../../../models/song.dart';
import '../../../repositories/slider_repository.dart';
import '../../../repositories/song_repository.dart';

class HomeController extends GetxController {
  SongRepository? songRepository;
  SliderRepository? sliderRepository;
  final popularsongs = <Song>[].obs;
  // final sliders = <Slide>[].obs;

  HomeController() {
    songRepository = SongRepository();
    sliderRepository = SliderRepository();
  }

  @override
  Future<void> onInit() async {
    await getPopularSongs();
    // await getSliders();
    super.onInit();
  }

  Future<void> getPopularSongs() async {
    try {
      List<Song> _songs = [];
      _songs = await songRepository!.getPopularSongs(1, 1);
      if (_songs.isNotEmpty) {
        popularsongs.addAll(_songs);
      }
    } catch (e) {
      Get.showSnackbar(Ui.errorSnackBar(message: "Ýalňyşlyk ýüze çykdy".tr));
    }
  }

  // Future<void> getSliders() async {
  //   try {
  //     List<Slide> _sliders = [];
  //     _sliders = await sliderRepository!.getSliders();
  //     if (_sliders.isNotEmpty) {
  //       sliders.addAll(_sliders);
  //     }
  //   } catch (e) {
  //     Get.showSnackbar(Ui.errorSnackBar(message: "Ýalňyşlyk ýüze çykdy".tr));
  //   }
  // }
}
