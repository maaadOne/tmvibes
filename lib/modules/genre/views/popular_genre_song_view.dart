import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:nb_utils/nb_utils.dart';
import '../../../models/song.dart';
import '../../../routes/app_routes.dart';
import '../../../utils/colors.dart';
import '../../../utils/helper_widget.dart';
import '../controller/genre_controller.dart';
import 'custom.dart';

class PopularSongScreen extends GetView<GenreController> {
  const PopularSongScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: mpAppBackGroundColor,
      appBar: AppBar(
        elevation: 0,
        centerTitle: true,
        iconTheme: const IconThemeData(color: Colors.white),
        title: Text(controller.genre.value.name!,
            style: boldTextStyle(color: Colors.white)),
        backgroundColor: mpAppBackGroundColor,
      ),
      body: Obx(() {
        return GridView.builder(
            padding: const EdgeInsets.symmetric(vertical: 10),
            controller: controller.scrollController,
            itemCount: controller.songs.length + 1,
            shrinkWrap: true,
            physics: const BouncingScrollPhysics(),
            gridDelegate:
                const SliverGridDelegateWithFixedCrossAxisCountAndFixedHeight(
              crossAxisCount: 2,
              crossAxisSpacing: 5,
              mainAxisSpacing: 5,
              height: 250.0, //48 dp of height
            ),
            itemBuilder: (context, index) {
              if (index == controller.songs.length) {
                return Container(
                  alignment: Alignment.center,
                  child: Align(
                    alignment: Alignment.center,
                    child: Opacity(
                      opacity: controller.isLoading.value ? 1 : 0,
                      child: const CircularProgressIndicator(
                        color: mpAppBackGroundColor,
                      ),
                    ),
                  ),
                );
              } else {
                return Obx(
                  () {
                    Song song = controller.songs.elementAt(index);
                    return GestureDetector(
                      onTap: () {
                        Get.toNamed(Routes.player, arguments: {
                          'songs': controller.songs,
                          'initial_index': index
                        });
                      },
                      child: SizedBox(
                        height: 350,
                        // color: Colors.red,
                        width: Get.size.width < 640 ? 150 : Get.size.width / 2,
                        child: Column(
                          children: [
                            CachedNetworkImage(
                              placeholder: placeholderWidgetFn() as Widget
                                  Function(BuildContext, String)?,
                              imageUrl: song.coverArtUrl!,
                              height: 170,
                              width: 170,
                              fit: BoxFit.cover,
                              errorWidget: (_, __, ___) {
                                return const SizedBox(height: 170, width: 170);
                              },
                            ),
                            // commonCacheImageWidget(song.coverArtUrl, 160,
                            //         fit: BoxFit.cover)
                            //     .cornerRadiusWithClipRRect(16),
                            4.height,
                            Marquee(
                              child: Text(song.name!,
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                  style: boldTextStyle(
                                      color: white.withOpacity(0.9))),
                            ),
                            4.height,
                            Marquee(
                              child: Text(song.artist!,
                                  maxLines: 2,
                                  overflow: TextOverflow.ellipsis,
                                  style: secondaryTextStyle(
                                      color: mpAppTextColor1)),
                            ),
                            10.height,
                          ],
                        ),
                      ),
                    );
                  },
                );
              }
            });
      }),
    );
  }
}
