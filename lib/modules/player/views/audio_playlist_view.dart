import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:nb_utils/nb_utils.dart';
import '../../../models/song.dart';
import '../../../routes/app_routes.dart';
import '../../../utils/colors.dart';
import '../controllers/audio_player_controller.dart';

class AudioPlaylistView extends GetView<AudioPlayerController> {
  const AudioPlaylistView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: mpAppBackGroundColor,
      appBar: AppBar(
        iconTheme: const IconThemeData(color: Colors.white),
        backgroundColor: mpSearchBarBackGroundColor,
        // title: TextField(
        //   style: primaryTextStyle(color: Colors.white),
        //   cursorColor: Colors.white,
        //   decoration: InputDecoration(
        //       hintText: 'Search on Music PodCast...',
        //       hintStyle: primaryTextStyle(color: Colors.white),
        //       border: InputBorder.none),
        // ),
        // actions: [
        //   const Icon(Icons.settings_voice_outlined).paddingOnly(right: 16),
        // ],
      ),
      body: ListView.separated(
        itemBuilder: (context, index) {
          Song song = controller.songs.elementAt(index);
          return GestureDetector(
            onTap: () {
              // controller.chageCurrentAlbum();
              // Get.toNamed(Routes.player, arguments: {
              //   'songs': controller.songs,
              //   'initial_index': index,
              //   'album': controller.album.value
              // });
            },
            child: Container(
              color: mpAppBackGroundColor,
              margin: const EdgeInsets.all(8),
              child: Row(
                children: [
                  Text((index + 1).toString(),
                      style: boldTextStyle(color: white.withOpacity(0.9))),
                  16.width,
                  // commonCacheImageWidget(data.img, 50,
                  //         width: 50, fit: BoxFit.cover)
                  //     .cornerRadiusWithClipRRect(10),
                  // 16.width,
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(song.name!,
                          style: boldTextStyle(color: white.withOpacity(0.9))),
                      4.height,
                      Text(song.artist!,
                          style: secondaryTextStyle(
                              color: white.withOpacity(0.5), size: 14)),
                    ],
                  ).expand(),
                  Row(
                    children: [
                      Text(song.duration.toString(),
                          style: secondaryTextStyle(color: white, size: 12)),
                      24.width,
                      Icon(Icons.more_horiz, color: white.withOpacity(0.9)),
                    ],
                  )
                  // Icon(Icons.more_horiz, color: white.withOpacity(0.9)),
                ],
              ),
            ),
          );
        },
        itemCount: controller.songs.length,
        separatorBuilder: (BuildContext context, int index) {
          return const SizedBox(height: 5);
        },
      ),
    );
  }
}
