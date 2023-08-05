import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:nb_utils/nb_utils.dart';
import '../../../models/album.dart';
import '../../../routes/app_routes.dart';
import '../../../utils/helper_widget.dart';
import '../../../utils/colors.dart';
import '../../genre/views/custom.dart';
import '../controllers/albums_controller.dart';

// ignore: must_be_immutable
class AlbumView extends GetView<AlbumsController> {
  const AlbumView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: mpAppBackGroundColor,
      body: Obx(
        () {
          return GridView.builder(
            physics: const BouncingScrollPhysics(),
            controller: controller.scrollController,
            itemCount: controller.albums.length + 1,
            itemBuilder: (context, index) {
              if (index == controller.albums.length) {
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
                    Album album = controller.albums.elementAt(index);
                    return GestureDetector(
                      onTap: () {
                        Get.toNamed(Routes.album, arguments: {"album": album});
                      },
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          CachedNetworkImage(
                            placeholder: placeholderWidgetFn() as Widget
                                Function(BuildContext, String)?,
                            imageUrl: album.imageUrl!,
                            height: 170,
                            width: 170,
                            fit: BoxFit.cover,
                            errorWidget: (_, __, ___) {
                              return const SizedBox(height: 170, width: 170);
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
                          Text(album.name!,
                              style: boldTextStyle(color: Colors.white),
                              maxLines: 1),
                          4.height,
                          Text(album.artistName!,
                              style: primaryTextStyle(
                                  color: Colors.grey, size: 14),
                              maxLines: 1),
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
                    height: 250),
          );
        },
      ),
    );
  }
}
