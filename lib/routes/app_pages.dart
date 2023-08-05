import 'package:get/get.dart' show GetPage;
import '../modules/album/bindings/album_binding.dart';
import '../modules/album/views/album_view.dart';
import '../modules/album/views/albums_detail_view.dart';
import '../modules/artist/bindings/artist_binding.dart';
import '../modules/artist/views/artist_detail_view.dart';
import '../modules/genre/bindings/genre_binding.dart';
import '../modules/genre/views/popular_genre_song_view.dart';
import '../modules/player/bindings/audio_player_binding.dart';
import '../modules/player/views/audio_player_view.dart';
import '../modules/player/views/audio_playlist_view.dart';
import '../modules/playlist/bindings/play_list_binding.dart';
import '../modules/playlist/views/playlist_view.dart';
import '../modules/root/bindings/root_binding.dart';
import '../modules/root/views/root_view.dart';
import '../modules/search/bindings/search_binding.dart';
import '../modules/search/views/search_view.dart';
import 'app_routes.dart';

class AppPages {
  static const initial = Routes.root;

  static final routes = [
    GetPage(
      name: Routes.root,
      page: () => const RootView(),
      binding: RootBinding(),
    ),
    GetPage(
      name: Routes.player,
      page: () => const AudioPlayerView(),
      binding: AudioPlayerBinding(),
    ),
    GetPage(
      name: Routes.audioPlayerPlaylist,
      page: () => const AudioPlaylistView(),
      binding: AudioPlayerBinding(),
    ),
    // SONGS
    // ALBUMS
    GetPage(
      name: Routes.albums,
      page: () => const AlbumView(),
      binding: AlbumBinding(),
    ),
    GetPage(
      name: Routes.album,
      page: () => const AlbumDetailView(),
      binding: AlbumBinding(),
    ),
    GetPage(
      name: Routes.playlist,
      page: () => PlaylistView(),
      binding: PlayListBinding(),
    ),
    GetPage(
      name: Routes.genreSongs,
      page: () => const PopularSongScreen(),
      binding: GenreBinding(),
    ),
    GetPage(
      name: Routes.artistSongs,
      page: () => const ArtistDetailView(),
      binding: ArtistBinding(),
    ),
    GetPage(
      name: Routes.search,
      page: () => const SearchView(),
      binding: SearchBinding(),
    ),
  ];
}
