import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:nb_utils/nb_utils.dart';
import '../../../models/artist.dart';
import '../../../routes/app_routes.dart';
import '../../../utils/helper_widget.dart';
import '../../../utils/colors.dart';
import '../../genre/views/custom.dart';
import '../controller/artists_controller.dart';

class ArtistsView extends GetView<ArtistsController> {
  const ArtistsView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: mpAppBackGroundColor,
      body: Obx(
        () {
          return GridView.builder(
            padding: const EdgeInsets.only(bottom: 50, left: 6, right: 6),
            physics: const BouncingScrollPhysics(),
            controller: controller.scrollController,
            itemCount: controller.artists.length + 1,
            itemBuilder: (context, index) {
              if (index == controller.artists.length) {
                return Obx(() {
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
                });
              } else {
                return Obx(
                  () {
                    Artist artist = controller.artists.elementAt(index);
                    return GestureDetector(
                      onTap: () {
                        Get.toNamed(Routes.artistSongs,
                            arguments: {"artist": artist});
                      },
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          CachedNetworkImage(
                            placeholder: placeholderWidgetFn() as Widget
                                Function(BuildContext, String)?,
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
                          // commonCacheImageWidget(album.imageUrl, 170,
                          //         fit: BoxFit.cover)
                          //     .cornerRadiusWithClipRRect(8)
                          //     .onTap(() {
                          //   Get.toNamed(Routes.album,
                          //       arguments: {"album": album});
                          //   // MPNowPlayingScreen(data: data).launch(context);
                          // }),
                          8.height,
                          Text(artist.name!,
                              style: boldTextStyle(color: Colors.white),
                              maxLines: 1),
                          // 4.height,
                          // Text(artist.!,
                          //     style: primaryTextStyle(
                          //         color: Colors.grey, size: 14),
                          //     maxLines: 1),
                        ],
                      ),
                    );
                  },
                );
              }
            },
            gridDelegate:
                const SliverGridDelegateWithFixedCrossAxisCountAndFixedHeight(
              crossAxisCount: 2, // set the number of columns here
              crossAxisSpacing: 1,
              mainAxisSpacing: 1,
              // childAspectRatio: 0.8,
              height: 230.0,
            ),
          );
        },
      ),
    );
  }
}
