import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:nb_utils/nb_utils.dart';
import '../../../models/album.dart';
import '../../../models/artist.dart';
import '../../../models/genre.dart';
import '../../../models/song.dart';
import '../../../routes/app_routes.dart';
import '../../../utils/colors.dart';
import '../../../utils/helper_widget.dart';
import '../controllers/search_controller.dart';

class SearchView extends GetView<SearchingController> {
  const SearchView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: mpAppBackGroundColor,
        appBar: AppBar(
          iconTheme: const IconThemeData(color: Colors.white),
          backgroundColor: mpSearchBarBackGroundColor,
          title: TextField(
            controller: controller.textEditingController,
            onSubmitted: (value) {
              controller.getSearchResults(value);
            },
            style: primaryTextStyle(color: Colors.white),
            cursorColor: Colors.white,
            autofocus: true,
            decoration: InputDecoration(
              hintText: 'Aýdymçy aýdymyň ady, albom ady ...',
              hintStyle: primaryTextStyle(color: Colors.white),
              border: InputBorder.none,
            ),
          ),
          // actions: [
          //   const Icon(Icons.settings_voice_outlined).paddingOnly(right: 16),
          // ],
        ),
        body: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 10),
          child: Column(
            children: [
              // SONGS
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Obx(() {
                    return controller.searchResults.value.songs != null &&
                            controller.searchResults.value.songs!.isNotEmpty
                        ? Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              10.height,
                              Padding(
                                padding: const EdgeInsets.only(left: 3.0),
                                child: Text(
                                  "Aýdymlar",
                                  style: boldTextStyle(
                                      color: Colors.white, size: 30),
                                ),
                              ),
                              14.height,
                              SizedBox(
                                height: 235,
                                // width: 200,
                                child: ListView.separated(
                                    // padding: const EdgeInsets.symmetric(
                                    //     horizontal: 8, vertical: 10),
                                    physics: const BouncingScrollPhysics(),
                                    scrollDirection: Axis.horizontal,
                                    itemCount: controller.searchResults.value
                                            .songs?.length ??
                                        0,
                                    itemBuilder: (context, index) {
                                      Song song = controller
                                          .searchResults.value.songs!
                                          .elementAt(index);
                                      if (controller
                                          .searchResults.value.songs!.isEmpty) {
                                        return const SizedBox();
                                      }

                                      return GestureDetector(
                                        onTap: () {
                                          Get.toNamed(Routes.player,
                                              arguments: {
                                                'song': song,
                                              });
                                        },
                                        child: Column(
                                          children: [
                                            SizedBox(
                                              width: 170,
                                              child: Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.center,
                                                children: [
                                                  CachedNetworkImage(
                                                    placeholder:
                                                        placeholderWidgetFn()
                                                            as Widget Function(
                                                                BuildContext,
                                                                String)?,
                                                    imageUrl: song.coverArtUrl!,
                                                    height: 170,
                                                    width: 170,
                                                    fit: BoxFit.cover,
                                                    errorWidget: (_, __, ___) {
                                                      return Image.asset(
                                                        'images/placeholder.jpg',
                                                        fit: BoxFit.cover,
                                                        height: 170,
                                                        width: 170,
                                                      );
                                                    },
                                                  ),
                                                  8.height,
                                                  Marquee(
                                                    child: Text(
                                                      song.name!,
                                                      style: boldTextStyle(
                                                          color: Colors.white),
                                                      maxLines: 1,
                                                      textAlign:
                                                          TextAlign.center,
                                                    ),
                                                  ),
                                                  4.height,
                                                  Marquee(
                                                    child: Text(
                                                      song.artist!,
                                                      style: boldTextStyle(
                                                          color: Colors.white),
                                                      maxLines: 1,
                                                      textAlign:
                                                          TextAlign.center,
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                            const Divider()
                                          ],
                                        ),
                                      );
                                    },
                                    separatorBuilder: (context, index) {
                                      return const SizedBox(width: 10);
                                    }),
                              ),
                              const Divider()
                            ],
                          )
                        : const SizedBox();
                  }),
                ],
              ),
              // ARTISTS
              Obx(() {
                return controller.searchResults.value.artists != null &&
                        controller.searchResults.value.artists!.isNotEmpty
                    ? Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          10.height,
                          Padding(
                            padding: const EdgeInsets.only(left: 3.0),
                            child: Text(
                              "Aýdymçylar",
                              style:
                                  boldTextStyle(color: Colors.white, size: 30),
                            ),
                          ),
                          14.height,
                          SizedBox(
                            height: 215,
                            // width: 200,
                            child: Obx(() {
                              return ListView.separated(
                                  // padding: const EdgeInsets.symmetric(
                                  //     horizontal: 8, vertical: 10),
                                  physics: const BouncingScrollPhysics(),
                                  scrollDirection: Axis.horizontal,
                                  itemCount: controller.searchResults.value
                                          .artists?.length ??
                                      0,
                                  itemBuilder: (context, index) {
                                    Artist artist = controller
                                        .searchResults.value.artists!
                                        .elementAt(index);
                                    if (controller
                                        .searchResults.value.artists!.isEmpty) {
                                      return const SizedBox();
                                    }

                                    return GestureDetector(
                                      onTap: () {
                                        Get.toNamed(Routes.artistSongs,
                                            arguments: {"artist": artist});
                                      },
                                      child: Column(
                                        children: [
                                          SizedBox(
                                            width: 170,
                                            child: Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.center,
                                              children: [
                                                CachedNetworkImage(
                                                  placeholder:
                                                      placeholderWidgetFn()
                                                          as Widget Function(
                                                              BuildContext,
                                                              String)?,
                                                  imageUrl: artist.imageUrl!,
                                                  height: 170,
                                                  width: 170,
                                                  fit: BoxFit.cover,
                                                  errorWidget: (_, __, ___) {
                                                    return Image.asset(
                                                      'images/placeholder.jpg',
                                                      fit: BoxFit.cover,
                                                      height: 170,
                                                      width: 170,
                                                    );
                                                  },
                                                ),
                                                8.height,
                                                Marquee(
                                                  child: Text(
                                                    artist.name!,
                                                    style: boldTextStyle(
                                                        color: Colors.white),
                                                    maxLines: 1,
                                                    textAlign: TextAlign.center,
                                                  ),
                                                ),
                                                // 4.height,
                                                // Marquee(
                                                //   child: Text(
                                                //     artist!,
                                                //     style: boldTextStyle(
                                                //         color: Colors.white),
                                                //     maxLines: 1,
                                                //     textAlign: TextAlign.center,
                                                //   ),
                                                // ),
                                              ],
                                            ),
                                          ),
                                          const Divider()
                                        ],
                                      ),
                                    );
                                  },
                                  separatorBuilder: (context, index) {
                                    return const SizedBox(width: 10);
                                  });
                            }),
                          ),
                          const Divider()
                        ],
                      )
                    : const SizedBox();
              }),
              // ARTISTS
              Obx(() {
                return controller.searchResults.value.albums != null &&
                        controller.searchResults.value.albums!.isNotEmpty
                    ? Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          10.height,
                          Padding(
                            padding: const EdgeInsets.only(left: 3.0),
                            child: Text(
                              "Albomlar",
                              style:
                                  boldTextStyle(color: Colors.white, size: 30),
                            ),
                          ),
                          14.height,
                          SizedBox(
                            height: 215,
                            // width: 200,
                            child: Obx(() {
                              return ListView.separated(
                                  // padding: const EdgeInsets.symmetric(
                                  //     horizontal: 8, vertical: 10),
                                  physics: const BouncingScrollPhysics(),
                                  scrollDirection: Axis.horizontal,
                                  itemCount: controller
                                          .searchResults.value.albums?.length ??
                                      0,
                                  itemBuilder: (context, index) {
                                    Album album = controller
                                        .searchResults.value.albums!
                                        .elementAt(index);
                                    if (controller
                                        .searchResults.value.albums!.isEmpty) {
                                      return const SizedBox();
                                    }

                                    return Column(
                                      children: [
                                        SizedBox(
                                          width: 170,
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.center,
                                            children: [
                                              CachedNetworkImage(
                                                placeholder:
                                                    placeholderWidgetFn()
                                                        as Widget Function(
                                                            BuildContext,
                                                            String)?,
                                                imageUrl: album.imageUrl!,
                                                height: 170,
                                                width: 170,
                                                fit: BoxFit.cover,
                                                errorWidget: (_, __, ___) {
                                                  return Image.asset(
                                                    'images/placeholder.jpg',
                                                    fit: BoxFit.cover,
                                                    height: 170,
                                                    width: 170,
                                                  );
                                                },
                                              ),
                                              8.height,
                                              Marquee(
                                                child: Text(
                                                  album.name!,
                                                  style: boldTextStyle(
                                                      color: Colors.white),
                                                  maxLines: 1,
                                                  textAlign: TextAlign.center,
                                                ),
                                              ),
                                              // 4.height,
                                              // Marquee(
                                              //   child: Text(
                                              //     artist!,
                                              //     style: boldTextStyle(
                                              //         color: Colors.white),
                                              //     maxLines: 1,
                                              //     textAlign: TextAlign.center,
                                              //   ),
                                              // ),
                                            ],
                                          ),
                                        ),
                                        const Divider()
                                      ],
                                    );
                                  },
                                  separatorBuilder: (context, index) {
                                    return const SizedBox(width: 10);
                                  });
                            }),
                          ),
                          const Divider()
                        ],
                      )
                    : const SizedBox();
              }),
              // GENRE
              Obx(() {
                return controller.searchResults.value.genres != null &&
                        controller.searchResults.value.genres!.isNotEmpty
                    ? Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          10.height,
                          Padding(
                            padding: const EdgeInsets.only(left: 3.0),
                            child: Text(
                              "Žanrlar",
                              style:
                                  boldTextStyle(color: Colors.white, size: 30),
                            ),
                          ),
                          14.height,
                          SizedBox(
                            height: 215,
                            // width: 200,
                            child: Obx(() {
                              return ListView.separated(
                                  // padding: const EdgeInsets.symmetric(
                                  //     horizontal: 8, vertical: 10),
                                  physics: const BouncingScrollPhysics(),
                                  scrollDirection: Axis.horizontal,
                                  itemCount: controller
                                          .searchResults.value.genres?.length ??
                                      0,
                                  itemBuilder: (context, index) {
                                    Genre genre = controller
                                        .searchResults.value.genres!
                                        .elementAt(index);
                                    if (controller
                                        .searchResults.value.genres!.isEmpty) {
                                      return const SizedBox();
                                    }

                                    return GestureDetector(
                                      onTap: () {
                                        Get.toNamed(Routes.genreSongs,
                                            arguments: {"genre": genre});
                                      },
                                      child: Column(
                                        children: [
                                          SizedBox(
                                            width: 170,
                                            child: Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.center,
                                              children: [
                                                CachedNetworkImage(
                                                  placeholder:
                                                      placeholderWidgetFn()
                                                          as Widget Function(
                                                              BuildContext,
                                                              String)?,
                                                  imageUrl: genre.imageUrl!,
                                                  height: 170,
                                                  width: 170,
                                                  fit: BoxFit.cover,
                                                  errorWidget: (_, __, ___) {
                                                    return Image.asset(
                                                      'images/placeholder.jpg',
                                                      fit: BoxFit.cover,
                                                      height: 170,
                                                      width: 170,
                                                    );
                                                  },
                                                ),
                                                8.height,
                                                Marquee(
                                                  child: Text(
                                                    genre.name!,
                                                    style: boldTextStyle(
                                                        color: Colors.white),
                                                    maxLines: 1,
                                                    textAlign: TextAlign.center,
                                                  ),
                                                ),
                                                // 4.height,
                                                // Marquee(
                                                //   child: Text(
                                                //     artist!,
                                                //     style: boldTextStyle(
                                                //         color: Colors.white),
                                                //     maxLines: 1,
                                                //     textAlign: TextAlign.center,
                                                //   ),
                                                // ),
                                              ],
                                            ),
                                          ),
                                          const Divider()
                                        ],
                                      ),
                                    );
                                  },
                                  separatorBuilder: (context, index) {
                                    return const SizedBox(width: 10);
                                  });
                            }),
                          ),
                          const Divider()
                        ],
                      )
                    : const SizedBox();
              }),
            ],
          ),
        ));
  }
}
