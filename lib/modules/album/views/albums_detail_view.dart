import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:nb_utils/nb_utils.dart';
import '../../../models/song.dart';
import '../../../routes/app_routes.dart';
import '../../../utils/colors.dart';
import '../../../utils/helper_widget.dart';
import '../controllers/album_controller.dart';

class AlbumDetailView extends GetView<AlbumController> {
  const AlbumDetailView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(controller.album.value.name!).center(),
        backgroundColor: mpAppBackGroundColor,
        iconTheme: const IconThemeData(color: Colors.white),
        actions: [
          searchIconWidget(
            onPressed: () {
              Get.toNamed(Routes.search);
            },
          ),
        ],
      ),
      backgroundColor: mpAppBackGroundColor,
      body: Obx(
        () {
          return ListView.separated(
            physics: const BouncingScrollPhysics(),
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
                    children: [
                      index == 0
                          ? Stack(
                              // alignment: AlignmentDirectional.bottomCenter,
                              children: [
                                commonCacheImageWidget(song.coverArtUrl, 240,
                                    width: Get.size.width, fit: BoxFit.cover),
                                Positioned(
                                  bottom: 0,
                                  right: 0,
                                  left: 0,
                                  child: Container(
                                    color: cardBackgroundBlackDark
                                        .withOpacity(0.9),
                                    padding: const EdgeInsets.only(
                                        left: 16, right: 16, bottom: 8),
                                    width: Get.size.width,
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            SizedBox(
                                              width: Get.size.width / 2,
                                              child: Marquee(
                                                child: Text(
                                                  controller.album.value.name!,
                                                  style: boldTextStyle(
                                                    color:
                                                        white.withOpacity(0.9),
                                                    size: 25,
                                                  ),
                                                ),
                                              ),
                                            ),
                                            4.height,
                                            Text(
                                                '${controller.album.value.songCount} aýdym',
                                                style: secondaryTextStyle(
                                                    color:
                                                        white.withOpacity(0.5),
                                                    size: 16)),

                                            // 10.height,
                                          ],
                                        ),
                                        Column(
                                          children: [
                                            4.height,
                                            commonCacheImageWidget(
                                                    controller
                                                        .album.value.imageUrl,
                                                    50,
                                                    width: 50,
                                                    fit: BoxFit.cover)
                                                .cornerRadiusWithClipRRect(25),
                                            8.height,
                                            Row(
                                              children: [
                                                const Icon(Icons.access_time,
                                                    color: white, size: 18),
                                                12.width,
                                                Text(
                                                    controller
                                                        .album.value.duration
                                                        .toString(),
                                                    style: secondaryTextStyle(
                                                        color: white
                                                            .withOpacity(0.5),
                                                        size: 14)),
                                              ],
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                                GestureDetector(
                                  onTap: () {
                                    controller.isThisAlbum.value
                                        ? controller.isPlayed.value
                                            ? controller.puseMedia()
                                            : controller.playMedia()
                                        : Get.toNamed(Routes.player,
                                                arguments: {
                                                'songs': controller.songs,
                                                'album': controller.album.value
                                              })!
                                            .then((value) =>
                                                controller.chageCurrentAlbum());
                                  },
                                  child: Row(
                                    children: [
                                      controller.isThisAlbum.value &&
                                              controller.isPlayed.value
                                          ? const Icon(
                                              Icons.pause_circle_outline,
                                              color: mpAppButtonColor,
                                              size: 45)
                                          : const Icon(
                                              Icons.play_circle_outline,
                                              color: mpAppButtonColor,
                                              size: 45),
                                      10.width,
                                      Text(
                                        'Play All',
                                        style: boldTextStyle(
                                            color: white.withOpacity(0.9),
                                            size: 25),
                                      ),
                                    ],
                                  ).paddingOnly(left: 16, top: 16),
                                ),
                              ],
                            )
                          : const SizedBox(),
                      GestureDetector(
                        onTap: () {
                          controller.chageCurrentAlbum();
                          Get.toNamed(Routes.player, arguments: {
                            'songs': controller.songs,
                            'initial_index': index,
                            'album': controller.album.value
                          });
                        },
                        child: Container(
                          color: mpAppBackGroundColor,
                          margin: const EdgeInsets.all(8),
                          child: Row(
                            children: [
                              Text((index + 1).toString(),
                                  style: boldTextStyle(
                                      color: white.withOpacity(0.9))),
                              16.width,
                              // commonCacheImageWidget(data.img, 50,
                              //         width: 50, fit: BoxFit.cover)
                              //     .cornerRadiusWithClipRRect(10),
                              // 16.width,
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  SizedBox(
                                    width: Get.size.width / 2,
                                    child: Marquee(
                                      child: Text(song.name!,
                                          style: boldTextStyle(
                                              color: white.withOpacity(0.9))),
                                    ),
                                  ),
                                  4.height,
                                  Text(song.artist!,
                                      style: secondaryTextStyle(
                                          color: white.withOpacity(0.5),
                                          size: 14)),
                                ],
                              ).expand(),
                              Row(
                                children: [
                                  Text(song.duration.toString(),
                                      style: secondaryTextStyle(
                                          color: white, size: 12)),
                                ],
                              )
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
        },
      ),
    );
  }

  // Future<void> showAddPlayList() async {
  //   return showModalBottomSheet(
  //     shape: const RoundedRectangleBorder(
  //         borderRadius: BorderRadius.vertical(top: Radius.circular(10))),
  //     context: context,
  //     builder: (BuildContext context) {
  //       return SizedBox(
  //         height: 240,
  //         child: Column(
  //           crossAxisAlignment: CrossAxisAlignment.start,
  //           children: [
  //             8.height,
  //             Row(
  //               mainAxisAlignment: MainAxisAlignment.spaceBetween,
  //               children: [
  //                 const SizedBox(),
  //                 Text('Add Playlist', style: boldTextStyle()),
  //                 const Icon(Icons.close, color: Colors.grey).onTap(() {
  //                   finish(context);
  //                 }).paddingOnly(right: 8),
  //               ],
  //             ),
  //             8.height,
  //             const Divider(thickness: 1),
  //             8.height,
  //             SizedBox(
  //               height: 130,
  //               child: ListView.builder(
  //                 padding: const EdgeInsets.only(left: 8, right: 8),
  //                 scrollDirection: Axis.horizontal,
  //                 itemCount: albumGridList.length,
  //                 itemBuilder: (BuildContext context, int index) {
  //                   MusicModel data = albumGridList[index];
  //                   return Column(
  //                     crossAxisAlignment: CrossAxisAlignment.start,
  //                     children: [
  //                       commonCacheImageWidget(
  //                         data.img,
  //                         100,
  //                         width: 100,
  //                         fit: BoxFit.cover,
  //                       ).cornerRadiusWithClipRRect(10),
  //                       4.height,
  //                       Text(data.title!,
  //                           style: secondaryTextStyle(
  //                               size: 13, color: Colors.grey),
  //                           maxLines: 1),
  //                     ],
  //                   ).paddingOnly(left: 8, right: 8);
  //                 },
  //               ),
  //             ),
  //             const Divider(thickness: 1),
  //             4.height,
  //             Row(
  //               mainAxisAlignment: MainAxisAlignment.center,
  //               children: [
  //                 const Icon(Icons.add, color: Colors.grey),
  //                 Text('Create New Playlist',
  //                         style:
  //                             secondaryTextStyle(size: 13, color: Colors.grey))
  //                     .center(),
  //               ],
  //             )
  //           ],
  //         ),
  //       );
  //     },
  //   );
  // }
}
