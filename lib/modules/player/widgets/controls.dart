import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:just_audio/just_audio.dart';
import '../../root/controllers/root_controller.dart';

class Controls extends GetView<RootController> {
  const Controls({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 50,
      // color: Colors.red,
      padding: EdgeInsets.zero,
      margin: EdgeInsets.zero,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          StreamBuilder<SequenceState?>(
              stream: controller.audioPlayer.sequenceStateStream,
              builder: (context, snapshot) {
                final data = snapshot.data;
                if (data != null &&
                    data.sequence.isNotEmpty &&
                    data.sequence.length != 1) {
                  return IconButton(
                    onPressed: controller.audioPlayer.seekToPrevious,
                    iconSize: Get.size.height < 600 ? 50 : 70,
                    color: Colors.white,
                    icon: const Icon(
                      Icons.skip_previous_rounded,
                    ),
                  );
                }
                return const SizedBox();
              }),
          StreamBuilder<PlayerState>(
            stream: controller.audioPlayer.playerStateStream,
            builder: (context, snapshot) {
              final playerState = snapshot.data;
              final processingState = playerState?.processingState;
              final playing = playerState?.playing;
              if (!(playing ?? false)) {
                return IconButton(
                  onPressed: controller.audioPlayer.play,
                  iconSize: Get.size.height < 600 ? 50 : 70,
                  color: Colors.white,
                  icon: const Icon(Icons.play_arrow_rounded),
                );
              } else if (processingState != ProcessingState.completed) {
                return IconButton(
                  onPressed: controller.audioPlayer.stop,
                  iconSize: Get.size.height < 600 ? 50 : 70,
                  color: Colors.white,
                  icon: const Icon(Icons.pause_rounded),
                );
              }
              return Icon(
                Icons.play_arrow_rounded,
                size: Get.size.height < 600 ? 50 : 70,
                color: Colors.white,
              );
            },
          ),
          StreamBuilder<SequenceState?>(
              stream: controller.audioPlayer.sequenceStateStream,
              builder: (context, snapshot) {
                final data = snapshot.data;
                if (data != null &&
                    data.sequence.isNotEmpty &&
                    data.sequence.length != 1) {
                  return IconButton(
                    onPressed: controller.audioPlayer.seekToNext,
                    iconSize: Get.size.height < 600 ? 50 : 70,
                    color: Colors.white,
                    icon: const Icon(
                      Icons.skip_next_rounded,
                    ),
                  );
                }

                return const SizedBox();
              }),
        ],
      ),
    );
  }
}
