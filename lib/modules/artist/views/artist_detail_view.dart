import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:nb_utils/nb_utils.dart';
import '../../../models/album.dart';
import '../../../models/song.dart';
import '../../../routes/app_routes.dart';
import '../../../utils/helper_widget.dart';
import '../../../utils/colors.dart';
import '../controller/artist_controller.dart';

class ArtistDetailView extends GetView<ArtistController> {
  const ArtistDetailView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: mpAppBackGroundColor,
      appBar: AppBar(
        title: Text(controller.artist.value.name!),
        centerTitle: true,
        backgroundColor: mpAppBackGroundColor,
        iconTheme: const IconThemeData(color: Colors.white),
        // actions: [
        //   searchIconWidget(
        //     onPressed: () {
        //       Get.toNamed(Routes.search);
        //     },
        //   ),
        // ],
      ),
      body: Obx(() {
        return ListView.separated(
          controller: controller.scrollController,
          itemCount: controller.songs.length + 1,
          itemBuilder: (context, index) {
            if (index == controller.songs.length) {
              return Obx(() {
                return SizedBox(
                  child: Center(
                    child: Opacity(
                      opacity: controller.isLoading.value ? 1 : 0,
                      child: const CircularProgressIndicator(
                        strokeWidth: 1,
                        color: iconColorPrimary,
                      ),
                    ),
                  ),
                );
              });
            } else {
              return Obx(() {
                Song song = controller.songs.elementAt(index);
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    index == 0
                        ? Stack(
                            fit: StackFit.passthrough,
                            children: [
                              commonCacheImageWidget(
                                  controller.artist.value.imageUrl, 250,
                                  width: Get.size.width, fit: BoxFit.cover),
                              Container(
                                  color: black.withOpacity(0.7),
                                  height: 251,
                                  width: Get.size.width),
                            ],
                          )
                        : const SizedBox(),
                    index == 0
                        ? Column(
                            children: [
                              controller.albums.isEmpty
                                  ? const SizedBox()
                                      .paddingOnly(left: 16, right: 16, top: 16)
                                  : Column(
                                      children: [
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            Text('Albomlar',
                                                style: boldTextStyle(
                                                    color: white
                                                        .withOpacity(0.9))),
                                          ],
                                        ).paddingOnly(
                                            left: 16, right: 16, top: 16),
                                        SizedBox(
                                          height: 215,
                                          child: ListView.builder(
                                            itemCount: controller.albums.length,
                                            padding: const EdgeInsets.all(8),
                                            scrollDirection: Axis.horizontal,
                                            itemBuilder: (BuildContext context,
                                                int index) {
                                              Album album = controller.albums
                                                  .elementAt(index);
                                              return GestureDetector(
                                                onTap: () {
                                                  Get.toNamed(Routes.album,
                                                      arguments: {
                                                        "album": album
                                                      });
                                                },
                                                child: Container(
                                                  margin:
                                                      const EdgeInsets.all(8),
                                                  width: 130,
                                                  child: Column(
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .start,
                                                    children: [
                                                      CachedNetworkImage(
                                                        placeholder:
                                                            placeholderWidgetFn()
                                                                as Widget Function(
                                                                    BuildContext,
                                                                    String)?,
                                                        imageUrl:
                                                            album.imageUrl!,
                                                        height: 130,
                                                        width: 130,
                                                        fit: BoxFit.cover,
                                                        errorWidget:
                                                            (_, __, ___) {
                                                          return const SizedBox(
                                                              height: 170,
                                                              width: 170);
                                                        },
                                                      ),
                                                      8.height,
                                                      Marquee(
                                                        child: Text(album.name!,
                                                            overflow:
                                                                TextOverflow
                                                                    .ellipsis,
                                                            maxLines: 1,
                                                            style:
                                                                boldTextStyle(
                                                                    color:
                                                                        white)),
                                                      ),
                                                      // .expand(),
                                                      4.height,
                                                      Text(
                                                          "${album.songCount} sany",
                                                          style: secondaryTextStyle(
                                                              color:
                                                                  mpAppTextColor)),
                                                    ],
                                                  ),
                                                ),
                                              );
                                            },
                                          ),
                                        ),
                                        Divider(color: white.withOpacity(0.1)),
                                      ],
                                    ),
                              10.height,
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text('Aýdymlar',
                                      style: boldTextStyle(
                                          color: white.withOpacity(0.9))),
                                ],
                              ).paddingOnly(left: 16, right: 16),
                              10.height,
                            ],
                          )
                        : const SizedBox(),
                    GestureDetector(
                      onTap: () {
                        Get.toNamed(Routes.player, arguments: {
                          "artist_songs": controller.songs,
                          "initial_index": index
                        });
                      },
                      child: Container(
                        color: mpAppBackGroundColor,
                        padding: const EdgeInsets.symmetric(horizontal: 10),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            8.height,
                            Row(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Row(
                                  children: [
                                    const Icon(Icons.play_circle_outline,
                                        color: mpAppButtonColor),
                                    16.width,
                                    SizedBox(
                                      width: Get.size.width / 2,
                                      child: Marquee(
                                          child: Text(song.name!,
                                              style: boldTextStyle(
                                                  color: white, size: 14))),
                                    ),
                                  ],
                                ),
                                Row(
                                  children: [
                                    Text(song.duration.toString(),
                                        style: secondaryTextStyle(
                                            color: white, size: 12)),
                                  ],
                                )
                              ],
                            ),
                            8.height,
                          ],
                        ),
                      ),
                    ),
                  ],
                );
              });
            }
          },
          separatorBuilder: (BuildContext context, int index) {
            return const SizedBox(height: 5);
          },
        );
      }),
    );
  }
}
