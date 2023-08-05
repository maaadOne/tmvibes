import 'package:cached_network_image/cached_network_image.dart';
import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:nb_utils/nb_utils.dart';
import '../../../models/song.dart';
import '../../../routes/app_routes.dart';
import '../../../utils/helper_widget.dart';
import '../../../utils/colors.dart';
import '../../genre/views/custom.dart';
import '../controller/home_controller.dart';

class HomeView extends GetView<HomeController> {
  const HomeView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    print("${Get.size.width}/${Get.size.height}");
    // 360.0/640.0 small, 412.0x732.0 medium, 480.0x853.0
    // 360.0x800.0
    // 411.0x960
    // 412.0x732.0
    // 412.0x883.0
    // 412.0x892
    // 412.0x916
    // 412.0x853
    // Tablet (small, medium, large)
    // 800.0x1280.0
    // 1024.0x1350.0
    // 1280.0x1888.0

    return Scaffold(
      backgroundColor: mpAppBackGroundColor,
      body: Obx(
        () {
          return GridView.builder(
            padding: const EdgeInsets.only(bottom: 50, left: 6, right: 6),
            physics: const BouncingScrollPhysics(),
            itemCount: controller.popularsongs.length,
            itemBuilder: (context, index) {
              return Obx(
                () {
                  Song song = controller.popularsongs.elementAt(index);
                  return GestureDetector(
                    onTap: () {
                      Get.toNamed(Routes.player, arguments: {
                        'song': song,
                      });
                    },
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        CachedNetworkImage(
                          placeholder: placeholderWidgetFn() as Widget Function(
                              BuildContext, String)?,
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
                        // commonCacheImageWidget(album.imageUrl, 170,
                        //         fit: BoxFit.cover)
                        //     .cornerRadiusWithClipRRect(8)
                        //     .onTap(() {
                        //   Get.toNamed(Routes.album,
                        //       arguments: {"album": album});
                        //   // MPNowPlayingScreen(data: data).launch(context);
                        // }),
                        8.height,
                        Text(song.name!,
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
            },
            gridDelegate:
                const SliverGridDelegateWithFixedCrossAxisCountAndFixedHeight(
              crossAxisCount: 2,
              crossAxisSpacing: 5,
              mainAxisSpacing: 5,
              height: 210.0, //48 dp of height
            ),
          );
        },
      ),
    );
  }
}
