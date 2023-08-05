import 'package:audio_video_progress_bar/audio_video_progress_bar.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:just_audio/just_audio.dart';
import 'package:just_audio_background/just_audio_background.dart';
import 'package:nb_utils/nb_utils.dart';

import '../models/position_data.dart';
import '../modules/root/controllers/root_controller.dart';
import '../routes/app_routes.dart';
import '../utils/helper_widget.dart';
import '../utils/colors.dart';

class BotomPlayer extends GetView<RootController> {
  const BotomPlayer({super.key});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Get.toNamed(Routes.player, arguments: {
          "songs":
              controller.audioPlayer.sequenceState!.currentSource!.tag.extras,
          'played': true,
        });

        // Get.toNamed(Routes.player, arguments: {"song": x});
      },
      child: Container(
        color: cardBackgroundBlackDark,
        height: 75,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            StreamBuilder<PositionData>(
              stream: controller.positionDataStream,
              builder: (context, snapshot) {
                final positionData = snapshot.data;

                return GestureDetector(
                  // onLongPress: () {
                  //   controller.isLongPressed = true;
                  //   print(controller.isLongPressed);
                  // },
                  // onLongPressEnd: (_) {
                  //   controller.isLongPressed= false;
                  //   print(controller.isLongPressed);
                  // },
                  // onLongPressMoveUpdate: (details) {
                  //   final RenderBox box =
                  //       context.findRenderObject() as RenderBox;
                  //   final localPosition =
                  //       box.globalToLocal(details.globalPosition);
                  //   final width = box.size.width;

                  //   final newValue = localPosition.dx / width;
                  //   final clampedValue = newValue.clamp(0.0, 1.0);

                  //   controller.seek(clampedValue);
                  // },
                  child: ProgressBar(
                    progress: positionData?.position ?? Duration.zero,
                    buffered: positionData?.bufferedPosition ?? Duration.zero,
                    total: positionData?.duration ?? Duration.zero,
                    onSeek: controller.audioPlayer.seek,
                    barHeight: 5,
                    thumbRadius: 5,
                    baseBarColor: Colors.grey[600],
                    bufferedBarColor: Colors.grey,
                    progressBarColor: mpAppButtonColor,
                    thumbColor: iconColorPrimary,
                    timeLabelLocation: TimeLabelLocation.none,
                  ),
                  // LinearPercentIndicator(
                  //   widgetIndicator: Container(
                  //     padding: const EdgeInsets.symmetric(
                  //         horizontal: 20, vertical: 5),
                  //     width: 15,
                  //     decoration: BoxDecoration(
                  //       color: iconColorPrimary,
                  //       borderRadius: BorderRadius.circular(29),
                  //     ),
                  //   ),
                  //   width: Get.size.width,
                  //   lineHeight: 5.0,
                  //   backgroundColor: mpAppButtonColor2,
                  //   percent: positionData != null
                  //       ? (positionData.position.inSeconds *
                  //               100 /
                  //               positionData.duration.inSeconds) /
                  //           100
                  //       : 0.0,
                  //   progressColor: mpAppButtonColor,
                  // ),
                );
              },
            ),
            // LinearPercentIndicator(
            //     width: context.width(),
            //     lineHeight: 2.0,
            //     percent: 0.6,
            //     progressColor: mpAppButtonColor),
            // 4.height,
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                StreamBuilder<SequenceState?>(
                  stream: controller.audioPlayer.sequenceStateStream,
                  builder: (context, snapshot) {
                    final state = snapshot.data;
                    if (state?.sequence.isEmpty ?? true) {
                      return const SizedBox();
                    }
                    final metadata = state!.currentSource!.tag as MediaItem;
                    return Expanded(
                      child: Row(
                        children: [
                          commonCacheImageWidget(metadata.artUri.toString(), 50,
                                  width: 50, fit: BoxFit.cover)
                              .cornerRadiusWithClipRRect(25),
                          16.width,
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Marquee(
                                // textDirection: TextDirection.ltr,
                                // animationDuration: const Duration(seconds: 2),
                                // backDuration: const Duration(milliseconds: 2000),
                                // pauseDuration: const Duration(milliseconds: 2000),
                                // directionMarguee: DirectionMarguee.oneDirection,
                                child: Text(metadata.title,
                                    style: boldTextStyle(
                                        color: white.withOpacity(0.8))),
                              ),
                              4.height,
                              Marquee(
                                // textDirection: TextDirection.ltr,
                                // animationDuration: const Duration(seconds: 2),
                                // backDuration: const Duration(milliseconds: 2000),
                                // pauseDuration: const Duration(milliseconds: 2000),
                                // directionMarguee: DirectionMarguee.oneDirection,
                                child: Text(metadata.artist!,
                                    maxLines: 2,
                                    overflow: TextOverflow.ellipsis,
                                    style: secondaryTextStyle(
                                        color: mpAppTextColor1)),
                              ),
                            ],
                          ).expand(),
                        ],
                      ),
                    );
                  },
                ),
                Row(
                  children: [
                    controller.audioPlayer.hasPrevious
                        ? const Icon(Icons.chevron_left_outlined,
                                color: mpAppButtonColor, size: 35)
                            .onTap(() {
                            controller.audioPlayer.seekToPrevious();
                          })
                        : const SizedBox(),
                    5.width,
                    StreamBuilder<PlayerState>(
                      stream: controller.audioPlayer.playerStateStream,
                      builder: (context, snapshot) {
                        final playerState = snapshot.data;
                        final processingState = playerState?.processingState;
                        final playing = playerState?.playing;
                        if (!(playing ?? false)) {
                          return const Icon(Icons.play_circle_outline,
                                  color: mpAppButtonColor, size: 35)
                              .onTap(() {
                            controller.audioPlayer.play();
                          });
                        } else if (processingState !=
                            ProcessingState.completed) {
                          return const Icon(Icons.pause_rounded,
                                  color: mpAppButtonColor, size: 35)
                              .onTap(() {
                            controller.audioPlayer.pause();
                          });
                        }
                        return const Icon(
                          Icons.play_arrow_rounded,
                          size: 80,
                          color: Colors.white,
                        );
                      },
                    ),
                    5.width,
                    controller.audioPlayer.hasNext
                        ? const Icon(Icons.keyboard_arrow_right,
                                color: mpAppButtonColor, size: 35)
                            .onTap(() {
                            controller.audioPlayer.seekToNext();
                          })
                        : const SizedBox(),
                  ],
                ),
              ],
            ).paddingOnly(left: 16, right: 16, bottom: 8, top: 4),
          ],
        ),
      ),
    );
  }
}
