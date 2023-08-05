import 'package:audio_video_progress_bar/audio_video_progress_bar.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:just_audio/just_audio.dart';
import 'package:just_audio_background/just_audio_background.dart';
import 'package:marquee_widget/marquee_widget.dart';
import '../../../models/position_data.dart';
import '../../../routes/app_routes.dart';
import '../../../utils/colors.dart';
import '../controllers/audio_player_controller.dart';
import '../widgets/controls.dart';

class AudioPlayerView extends GetView<AudioPlayerController> {
  const AudioPlayerView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      // backgroundColor: mpAppBackGroundColor,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        iconTheme: const IconThemeData(color: iconColorPrimary),
        actions: [
          StreamBuilder<SequenceState?>(
            stream: controller.audioPlayer.sequenceStateStream,
            builder: (context, snapshot) {
              final data = snapshot.data;
              return (data != null &&
                      data.sequence.isNotEmpty &&
                      data.sequence.length != 1)
                  ? IconButton(
                      onPressed: () {
                        Get.toNamed(Routes.audioPlayerPlaylist);
                      },
                      icon: const Icon(CupertinoIcons.music_note_list),
                    )
                  : IconButton(
                      onPressed: () {
                        controller.downloadTrack();
                      },
                      icon: const Icon(
                        Icons.download,
                        color: iconColorPrimary,
                      ),
                    );
            },
          ),
        ],
      ),
      body: Stack(
        fit: StackFit.expand,
        children: [
          StreamBuilder<SequenceState?>(
            stream: controller.audioPlayer.sequenceStateStream,
            builder: (context, snapshot) {
              final state = snapshot.data;
              if (state?.sequence.isEmpty ?? true) {
                return const SizedBox();
              }
              final metadata = state!.currentSource!.tag as MediaItem;
              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  CachedNetworkImage(
                    imageUrl: metadata.artUri.toString(),
                  ),
                ],
              );
            },
          ),
          const _BackgroundFilter(),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.end,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                StreamBuilder<SequenceState?>(
                  stream: controller.audioPlayer.sequenceStateStream,
                  builder: (context, snapshot) {
                    final state = snapshot.data;
                    if (state?.sequence.isEmpty ?? true) {
                      return const SizedBox();
                    }
                    final metadata = state!.currentSource!.tag as MediaItem;
                    return Column(
                      children: [
                        Marquee(
                          textDirection: TextDirection.ltr,
                          animationDuration: const Duration(seconds: 2),
                          backDuration: const Duration(milliseconds: 2000),
                          pauseDuration: const Duration(milliseconds: 2000),
                          directionMarguee: DirectionMarguee.oneDirection,
                          child: Text(
                            metadata.title,
                            maxLines: 1,
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: Get.size.height < 600 ? 18 : 22,
                              fontWeight: FontWeight.bold,
                            ),
                            textAlign: TextAlign.center,
                          ),
                        ),
                        const SizedBox(height: 8),
                        Marquee(
                          textDirection: TextDirection.ltr,
                          animationDuration: const Duration(seconds: 2),
                          backDuration: const Duration(milliseconds: 2000),
                          pauseDuration: const Duration(milliseconds: 2000),
                          directionMarguee: DirectionMarguee.oneDirection,
                          child: Text(
                            metadata.artist!,
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: Get.size.height < 600 ? 16 : 18,
                              fontWeight: FontWeight.bold,
                            ),
                            textAlign: TextAlign.center,
                          ),
                        ),
                      ],
                    );
                  },
                ),
                const SizedBox(height: 20),
                StreamBuilder<PositionData>(
                  stream: controller.positionDataStream,
                  builder: (context, snapshot) {
                    final positionData = snapshot.data;
                    return ProgressBar(
                      timeLabelPadding: 10,
                      progress: positionData?.position ?? Duration.zero,
                      buffered: positionData?.bufferedPosition ?? Duration.zero,
                      total: positionData?.duration ?? Duration.zero,
                      onSeek: controller.audioPlayer.seek,
                      barHeight: 5,
                      thumbGlowRadius: 5,
                      baseBarColor: Colors.grey[600],
                      bufferedBarColor: Colors.grey,
                      progressBarColor: mpAppButtonColor,
                      thumbColor: iconColorPrimary,
                      timeLabelTextStyle: const TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.w600,
                      ),
                    );
                  },
                ),
                const Controls(),
                const SizedBox(height: 70),
              ],
            ),
          ),
        ],
      ),

      // Container(
      //   padding: const EdgeInsets.all(20),
      //   height: double.infinity,
      //   width: double.infinity,
      //   color: mpAppBackGroundColor,
      //   child: Column(
      //     mainAxisAlignment: MainAxisAlignment.center,
      //     children: [
      //       const SizedBox(height: 50),

      //       StreamBuilder<SequenceState?>(
      //         stream: controller.audioPlayer.sequenceStateStream,
      //         builder: (context, snapshot) {
      //           final state = snapshot.data;
      //           if (state?.sequence.isEmpty ?? true) {
      //             return const SizedBox();
      //           }
      //           final metadata = state!.currentSource!.tag as MediaItem;
      //           return MediaMetaData(
      //             imageUrl: metadata.artUri.toString(),
      //             title: metadata.title,
      //             artist: metadata.artist ?? "",
      //           );
      //         },
      //       ),
      //       SizedBox(height: Get.size.height < 600 ? 10 : 50),
      //       StreamBuilder<PositionData>(
      //         stream: controller.positionDataStream,
      //         builder: (context, snapshot) {
      //           final positionData = snapshot.data;
      //           return ProgressBar(
      //             timeLabelPadding: 10,
      //             progress: positionData?.position ?? Duration.zero,
      //             buffered: positionData?.bufferedPosition ?? Duration.zero,
      //             total: positionData?.duration ?? Duration.zero,
      //             onSeek: controller.audioPlayer.seek,
      //             barHeight: 8,
      //             baseBarColor: Colors.grey[600],
      //             bufferedBarColor: Colors.grey,
      //             progressBarColor: mpAppButtonColor,
      //             thumbColor: iconColorPrimary,
      //             timeLabelTextStyle: const TextStyle(
      //               color: Colors.white,
      //               fontWeight: FontWeight.w600,
      //             ),
      //           );
      //         },
      //       ),
      //       // const SizedBox(height: 20),
      //       Get.size.height < 600
      //           ? const Expanded(child: Controls())
      //           : const Controls()
      //     ],
      //   ),
      // ),
      // BOTTOM CONTROLS
      bottomNavigationBar: StreamBuilder<SequenceState?>(
        stream: controller.audioPlayer.sequenceStateStream,
        builder: (context, snapshot) {
          final data = snapshot.data;

          return Container(
            color: mpAppBackGroundColor,
            height: 80,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                (data != null &&
                        data.sequence.isNotEmpty &&
                        data.sequence.length != 1)
                    ? IconButton(
                        onPressed: () {
                          controller.loopChange();
                        },
                        icon: Icon(
                          data.loopMode == LoopMode.all
                              ? CupertinoIcons.repeat
                              : CupertinoIcons.repeat_1,
                          color: iconColorPrimary,
                        ))
                    : const SizedBox(),
                (data != null &&
                        data.sequence.isNotEmpty &&
                        data.sequence.length != 1)
                    ? IconButton(
                        onPressed: () {
                          controller.downloadTrack();
                        },
                        icon: const Icon(
                          Icons.download,
                          color: iconColorPrimary,
                        ),
                      )
                    : const SizedBox(),
                (data != null &&
                        data.sequence.isNotEmpty &&
                        data.sequence.length != 1)
                    ? IconButton(
                        onPressed: () {
                          controller.shufleAudio();
                        },
                        icon: const Icon(
                          CupertinoIcons.shuffle,
                          color: iconColorPrimary,
                        ),
                      )
                    : const SizedBox(),
              ],
            ),
          );
        },
      ),
    );
  }
}

class _BackgroundFilter extends StatelessWidget {
  const _BackgroundFilter({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return ShaderMask(
      shaderCallback: (rect) {
        return LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              Colors.white,
              Colors.white.withOpacity(0.1),
              Colors.white.withOpacity(0.0),
            ],
            stops: const [
              0.0,
              0.3,
              0.5
            ]).createShader(rect);
      },
      blendMode: BlendMode.dstOut,
      child: Container(
          decoration: const BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [
            mpSearchBarBackGroundColor,
            mpAppBackGroundColor,
          ],
        ),
      )),
    );
  }
}
