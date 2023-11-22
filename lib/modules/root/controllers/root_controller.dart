import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:just_audio/just_audio.dart';
import 'package:rxdart/rxdart.dart' as rx;
import '../../../models/position_data.dart';
import 'dart:async';
import '../../album/views/album_view.dart';
import '../../artist/views/artists_view.dart';
import '../../genre/views/genres_view.dart';
import '../../home/views/home_view.dart';

class RootController extends GetxController {
  final currentIndex = 0.obs;
  AudioPlayer audioPlayer = AudioPlayer();
  // RewardedAd? ad;

  // @override
  // void onInit() async {
  //   super.onInit();
  //   // await showRewardOn();
  // }

  Stream<PositionData> get positionDataStream =>
      rx.Rx.combineLatest3<Duration, Duration, Duration?, PositionData>(
        audioPlayer.positionStream,
        audioPlayer.bufferedPositionStream,
        audioPlayer.durationStream,
        (position, bufferedPosition, duration) => PositionData(
          position,
          bufferedPosition,
          duration ?? Duration.zero,
        ),
      );

  List<Widget> pages = [
    const HomeView(),
    const ArtistsView(),
    const GenresView(),
    const AlbumView(),
  ];

  Widget get currentPage => pages[currentIndex.value];

  /// change page in route
  /// */
  void changePageInRoot(int index) {
    currentIndex.value = index;
  }

  void changePage(int index) {
    changePageInRoot(index);
  }

  @override
  void onClose() {
    // _myBoolController.close();
    audioPlayer.dispose();
    super.dispose();
  }

  // Future<void> showRewardOn() async {
  //   ad = await RewardedAd.create(
  //     adUnitId: 'R-M-2542694-1',
  //     onAdFailedToLoad: (error) {
  //       // isFailedToGetAds.value = true;
  //       /* Do something */
  //     },
  //   );
  //   await ad!.load(adRequest: const AdRequest());
  //   await ad!.show();
  //   final reward = await ad!.waitForDismiss();

  //   if (reward == null) {
  //     // Start downloading the first item in the list
  //     // audioPlayer.stop();
  //     SystemChannels.platform.invokeMethod('SystemNavigator.pop');
  //   }
  //   print("GORDU");
  // }
}
