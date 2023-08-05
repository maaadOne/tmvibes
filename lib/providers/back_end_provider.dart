import 'package:dio/dio.dart' as dio;
import 'package:get/get.dart';
import '../models/album.dart';
import '../models/artist.dart';
import '../models/genre.dart';
import '../models/play_list.dart';
import '../models/search.dart';
import '../models/slide_model.dart';
import '../models/song.dart';
import 'api_provider.dart';

class BackEndApiClient extends GetxService with ApiClient {
  dio.Dio? _httpClient;
  final dio.Options _optionsNetwork = dio.Options(headers: {
    "User-Agent":
        "Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/91.0.4472.124 Safari/537.36"
  });

  BackEndApiClient() {
    baseUrl = globalService.baseUrl;
    _httpClient = dio.Dio();
  }

  Future<BackEndApiClient> init() async {
    return this;
  }

  //Genre request
  Future<List<Genre>> getGenre(int page) async {
    var queryParameters = {
      'offset': ((page - 1) * 100).toString(),
      'max': '100'
    };

    Uri uri = getApiBaseUri("genre").replace(queryParameters: queryParameters);
    Get.log(uri.toString());
    var response = await _httpClient!.getUri(uri, options: _optionsNetwork);
    if (response.statusCode == 200) {
      return response.data['data']
          .map<Genre>((obj) => Genre.fromJson(obj))
          .toList();
    } else {
      throw Exception("error genre");
    }
  }

  //Songs request
  Future<List<Song>> getSongs(int page) async {
    var queryParameters = {
      'offset': ((page - 1) * 40).toString(),
      'max': '40',
      'sort': 'sortingDate',
      'order': 'desc'
    };

    Uri uri = getApiBaseUri("song").replace(queryParameters: queryParameters);
    Get.log(uri.toString());
    var response = await _httpClient!.getUri(uri, options: _optionsNetwork);
    if (response.statusCode == 200) {
      return response.data['data']
          .map<Song>((obj) => Song.fromJson(obj))
          .toList();
    } else {
      throw Exception("error songs");
    }
  }

  //Top Songs request
  Future<List<Song>> getTopSongs(int page, int typeId) async {
    var queryParameters = {
      'offset': ((page - 1) * 100).toString(),
      'max': '100',
      'order': 'desc',
      'dc': 'lasted',
      'sort': 'popular',
      'songTypeId': typeId.toString()
    };

    Uri uri = getApiBaseUri("song").replace(queryParameters: queryParameters);
    Get.log(uri.toString());
    var response = await _httpClient!.getUri(uri, options: _optionsNetwork);
    if (response.statusCode == 200) {
      return response.data['data']
          .map<Song>((obj) => Song.fromJson(obj))
          .toList();
    } else {
      throw Exception("error songs");
    }
  }

  //Artist request
  Future<List<Artist>> getArtists(int page, int typeId) async {
    var queryParameters = {
      'offset': ((page - 1) * 60).toString(),
      'max': '60',
      'order': 'desc',
      'partial': 'true',
      'sort': 'mlCount',
      'artistTypeId': typeId.toString()
    };

    Uri uri = getApiBaseUri("artist").replace(queryParameters: queryParameters);
    Get.log(uri.toString());
    var response = await _httpClient!.getUri(uri, options: _optionsNetwork);
    if (response.statusCode == 200) {
      return response.data['data']
          .map<Artist>((obj) => Artist.fromJson(obj))
          .toList();
    } else {
      throw Exception("error artist");
    }
  }

  //Album request
  Future<List<Album>> getAlbums(int page) async {
    var queryParameters = {'offset': ((page - 1) * 24).toString(), 'max': '24'};

    Uri uri = getApiBaseUri("album").replace(queryParameters: queryParameters);
    Get.log(uri.toString());
    var response = await _httpClient!.getUri(uri, options: _optionsNetwork);
    if (response.statusCode == 200) {
      return response.data['data']
          .map<Album>((obj) => Album.fromJson(obj))
          .toList();
    } else {
      throw Exception("error albums");
    }
  }

  //Playlist request
  Future<List<PlayList>> getPlayLists(int page) async {
    var queryParameters = {'offset': ((page - 1) * 24).toString(), 'max': '24'};

    Uri uri =
        getApiBaseUri("playlist").replace(queryParameters: queryParameters);
    Get.log(uri.toString());
    var response = await _httpClient!.getUri(uri, options: _optionsNetwork);
    if (response.statusCode == 200) {
      return response.data['data']
          .map<PlayList>((obj) => PlayList.fromJson(obj))
          .toList();
    } else {
      throw Exception("error play_lists");
    }
  }

  //Artist Songs request
  Future<List<Song>> getArtistSongs(int page, int artistId) async {
    var queryParameters = {
      'offset': ((page - 1) * 20).toString(),
      'max': '20',
      'artistId': artistId.toString()
    };

    Uri uri = getApiBaseUri("song").replace(queryParameters: queryParameters);
    Get.log(uri.toString());
    var response = await _httpClient!.getUri(uri, options: _optionsNetwork);
    if (response.statusCode == 200) {
      return response.data['data']
          .map<Song>((obj) => Song.fromJson(obj))
          .toList();
    } else {
      throw Exception("error songs");
    }
  }

  //Artist Album request
  Future<List<Album>> getArtistAlbums(int page, int artistID) async {
    var queryParameters = {
      'offset': ((page - 1) * 24).toString(),
      'max': '24',
      'sort': 'popular',
      'artistId': artistID.toString()
    };

    Uri uri = getApiBaseUri("album").replace(queryParameters: queryParameters);
    Get.log(uri.toString());
    var response = await _httpClient!.getUri(uri, options: _optionsNetwork);
    if (response.statusCode == 200) {
      return response.data['data']
          .map<Album>((obj) => Album.fromJson(obj))
          .toList();
    } else {
      throw Exception("error albums");
    }
  }

  //Album Songs request
  Future<List<Song>> getAlbumSongs(int page, int albumID) async {
    var queryParameters = {
      'offset': ((page - 1) * 50).toString(),
      'max': '50',
      'sort': 'albumOrder',
      'order': 'asc',
      'albumId': albumID.toString()
    };

    Uri uri = getApiBaseUri("song").replace(queryParameters: queryParameters);
    Get.log(uri.toString());
    var response = await _httpClient!.getUri(uri, options: _optionsNetwork);
    if (response.statusCode == 200) {
      return response.data['data']
          .map<Song>((obj) => Song.fromJson(obj))
          .toList();
    } else {
      throw Exception("error songs");
    }
  }

  //Playlist Songs request
  Future<List<Song>> getPlayListSongs(int page, int playListID) async {
    // ?statShow=false&offset=100&max=100&playlistId=90196
    var queryParameters = {
      'offset': ((page - 1) * 100).toString(),
      'max': '100',
      'statShow': 'statShow',
      'playlistId': playListID.toString()
    };

    Uri uri = getApiBaseUri("song").replace(queryParameters: queryParameters);
    Get.log(uri.toString());
    var response = await _httpClient!.getUri(uri, options: _optionsNetwork);
    if (response.statusCode == 200) {
      return response.data['data']
          .map<Song>((obj) => Song.fromJson(obj))
          .toList();
    } else {
      throw Exception("error songs");
    }
  }

  //Genre Songs request
  Future<List<Song>> getGenreSongs(int page, int genreID) async {
    // ?statShow=false&offset=100&max=100&playlistId=90196
    var queryParameters = {
      'offset': ((page - 1) * 50).toString(),
      'max': '50',
      'sort': 'popular',
      'genreId': genreID.toString()
    };

    Uri uri = getApiBaseUri("song").replace(queryParameters: queryParameters);
    Get.log(uri.toString());
    var response = await _httpClient!.getUri(uri, options: _optionsNetwork);
    if (response.statusCode == 200) {
      return response.data['data']
          .map<Song>((obj) => Song.fromJson(obj))
          .toList();
    } else {
      throw Exception("error songs");
    }
  }

  Future<List<Slide>> getHomeSlider() async {
    Uri uri = Uri.parse("https://beauty.vakstore.com.tm/api/slides");
    Get.log(uri.toString());
    var response = await _httpClient!.getUri(uri, options: _optionsNetwork);
    if (response.data['success'] == true) {
      return response.data['data']
          .map<Slide>((obj) => Slide.fromJson(obj))
          .toList();
    } else {
      throw Exception(response.data['message']);
    }
  }

  Future<Search> search(String mask) async {
    var queryParameters = {
      'mask': mask,
    };
    Uri uri = getApiBaseUri("search").replace(queryParameters: queryParameters);
    var response = await _httpClient!.getUri(uri, options: _optionsNetwork);
    if (response.statusCode == 200) {
      return Search.fromJson(response.data);
    } else {
      throw Exception(response.data['message']);
    }
  }
}
