import 'dart:math';
import 'package:get/get.dart';
import 'package:just_audio/just_audio.dart';
import 'package:just_audio_background/just_audio_background.dart';
import 'package:rxdart/rxdart.dart' as rx;
import '../../../models/album.dart';
import '../../../models/position_data.dart';
import '../../../models/song.dart';
import '../../../services/download_service.dart';
import '../../root/controllers/root_controller.dart';

class AudioPlayerController extends GetxController {
  AudioPlayer audioPlayer = Get.find<RootController>().audioPlayer;
  final songs = <Song>[].obs;
  final album = Album().obs;
  final downloadService = DownloadService();
  final initialIndex = 0.obs;
  var audioOnTop = false.obs;

  @override
  void onInit() async {
    var arguments = Get.arguments as Map<String, dynamic>;

    if (arguments.containsKey('songs') && arguments['songs'] != null) {
      if (!arguments.containsKey('played')) {
        songs.clear();
        songs.addAll(arguments['songs'] as List<Song>);
        if (arguments.containsKey("initial_index")) {
          initialIndex.value = arguments['initial_index'] as int;
        }
        if (arguments.containsKey("album")) {
          album.value = arguments['album'] as Album;
        }
        init();
      } else {
        var songList =
            arguments['songs']["songs_list"] as List<Map<String, dynamic>>;
        var songL = songList.map((value) => Song.fromJson(value)).toList();
        songs.addAll(songL);
      }
    } else if (arguments.containsKey('song') && arguments['song'] != null) {
      if (!arguments.containsKey('played')) {
        songs.clear();
        songs.add(arguments['song'] as Song);
        init();
      } else {
        songs.add(arguments['song'] as Song);
      }
    } else if (arguments.containsKey("artist_songs") &&
        arguments['artist_songs'] != null) {
      if (!arguments.containsKey('played')) {
        songs.clear();
        songs.addAll(arguments['artist_songs'] as List<Song>);
        if (arguments.containsKey("initial_index")) {
          initialIndex.value = arguments['initial_index'] as int;
        }
        init();
      } else {
        var songList =
            arguments['songs']["songs_list"] as List<Map<String, dynamic>>;
        var songL = songList.map((value) => Song.fromJson(value)).toList();
        songs.addAll(songL);
      }
    }

    super.onInit();
  }

  void downloadTrack() {
    int? curenntIndex = audioPlayer.currentIndex;
    if (curenntIndex != null) {
      downloadService.startDownload(songs[curenntIndex].url!);
    }
  }

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

  Future<void> fetchTracksAndPlay() async {
    final List<AudioSource> sources = generateList();

    final ConcatenatingAudioSource playlist =
        ConcatenatingAudioSource(children: sources);
    await audioPlayer.setShuffleModeEnabled(false);
    await audioPlayer.setAudioSource(playlist,
        initialIndex: initialIndex.value);
    audioPlayer.play();
  }

  Future<void> init() async {
    await audioPlayer.setLoopMode(LoopMode.all);

    await fetchTracksAndPlay();
  }

  Future<void> shufleAudio() async {
    final List<AudioSource> sources = generateList();

    final ConcatenatingAudioSource playlist = ConcatenatingAudioSource(
      children: sources,
      shuffleOrder: DefaultShuffleOrder(random: Random()),
    );
    await audioPlayer.setShuffleModeEnabled(true);
    await audioPlayer.setAudioSource(playlist);
  }

  Future<void> loopChange() async {
    if (audioPlayer.loopMode == LoopMode.all) {
      await audioPlayer.setLoopMode(LoopMode.one);
    } else {
      await audioPlayer.setLoopMode(LoopMode.all);
    }
  }

  List<AudioSource> generateList() {
    final List<AudioSource> sources = [];
    for (final trackData in songs) {
      final source = AudioSource.uri(
        Uri.parse(trackData.url!),
        tag: MediaItem(
            title: trackData.name!,
            artUri: Uri.parse(trackData.coverArtUrl!),
            artist: trackData.artist,
            id: trackData.id.toString(),
            extras: <String, dynamic>{
              "songs_list": songListToJson(songs),
              "album_id": album.value.id
            }
            // duration: Helper.parseDuration(duration),
            ),
      );
      sources.add(source);
    }
    return sources;
  }
}
