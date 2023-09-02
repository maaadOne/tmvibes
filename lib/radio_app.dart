import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:just_audio/just_audio.dart';
import 'package:just_audio_background/just_audio_background.dart';
import 'package:marquee_widget/marquee_widget.dart';
import 'package:tmvibes/utils/app_theme.dart';
import 'models/position_data.dart';
import 'package:rxdart/rxdart.dart' as rx;
import 'utils/colors.dart';

class MyRadio extends StatefulWidget {
  MyRadio({super.key});

  @override
  State<MyRadio> createState() => _MyRadioState();
}

class _MyRadioState extends State<MyRadio> {
  AudioPlayer audioPlayer = AudioPlayer();
  final radios = [
    {
      "id": "1",
      "name": "Owaz",
      "url": "http://217.174.229.54:7980/Owaz",
      "image": "assets/images/owaz.png",
    },
    {
      "id": "2",
      "name": "Watan",
      "url": "http://217.174.229.54:7981/Watan",
      "image": "assets/images/watan.png",
    },
    {
      "id": "3",
      "name": "Çar tarapdan",
      "url": "http://217.174.229.54:7982/Char-tarapdan",
      "image": "assets/images/tarapdan.png",
    },
    {
      "id": "4",
      "name": "Miras",
      "url": "http://217.174.229.54:7983/Miras",
      "image": "assets/images/miras.png",
    }
  ];

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

  @override
  void initState() {
    final List<AudioSource> sources = [];

    for (final station in radios) {
      final source = AudioSource.uri(
        Uri.parse(station["url"].toString()),
        tag: MediaItem(
          id: station["id"].toString(),
          title: station["name"].toString(),
          extras: {"image": station["image"].toString()},
        ),
      );
      sources.add(source);
    }
    final ConcatenatingAudioSource playlist = ConcatenatingAudioSource(
      children: sources,
    );
    audioPlayer.setAudioSource(playlist);
    audioPlayer.setLoopMode(LoopMode.all);
    // await audioPlayer.play();
    super.initState();
  }

  @override
  void dispose() {
    audioPlayer.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: AppThemeData.darkTheme,
      home: Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: const Text("tmvibes Radio"),
        ),
        body: Stack(
          fit: StackFit.expand,
          children: [
            StreamBuilder<SequenceState?>(
              stream: audioPlayer.sequenceStateStream,
              builder: (context, snapshot) {
                final state = snapshot.data;
                if (state?.sequence.isEmpty ?? true) {
                  return const SizedBox();
                }
                final metadata = state!.currentSource!.tag as MediaItem;
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Image.asset(
                      metadata.extras!["image"].toString(),
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
                    stream: audioPlayer.sequenceStateStream,
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
                        ],
                      );
                    },
                  ),
                  const SizedBox(height: 20),
                  Container(
                    height: 50,
                    padding: EdgeInsets.zero,
                    margin: EdgeInsets.zero,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        StreamBuilder<SequenceState?>(
                            stream: audioPlayer.sequenceStateStream,
                            builder: (context, snapshot) {
                              final data = snapshot.data;
                              if (data != null &&
                                  data.sequence.isNotEmpty &&
                                  data.sequence.length != 1) {
                                return IconButton(
                                  onPressed: audioPlayer.seekToPrevious,
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
                          stream: audioPlayer.playerStateStream,
                          builder: (context, snapshot) {
                            final playerState = snapshot.data;
                            final processingState =
                                playerState?.processingState;
                            final playing = playerState?.playing;
                            if (!(playing ?? false)) {
                              return IconButton(
                                onPressed: audioPlayer.play,
                                iconSize: Get.size.height < 600 ? 50 : 70,
                                color: Colors.white,
                                icon: const Icon(Icons.play_arrow_rounded),
                              );
                            } else if (processingState !=
                                ProcessingState.completed) {
                              return IconButton(
                                onPressed: audioPlayer.stop,
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
                          stream: audioPlayer.sequenceStateStream,
                          builder: (context, snapshot) {
                            final data = snapshot.data;
                            if (data != null &&
                                data.sequence.isNotEmpty &&
                                data.sequence.length != 1) {
                              return IconButton(
                                onPressed: audioPlayer.seekToNext,
                                iconSize: Get.size.height < 600 ? 50 : 70,
                                color: Colors.white,
                                icon: const Icon(
                                  Icons.skip_next_rounded,
                                ),
                              );
                            }
                            return const SizedBox();
                          },
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 70),
                ],
              ),
            ),
          ],
        ),
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
