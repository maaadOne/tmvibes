import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:marquee_widget/marquee_widget.dart';

class MediaMetaData extends StatelessWidget {
  const MediaMetaData({
    super.key,
    required this.imageUrl,
    required this.title,
    required this.artist,
  });

  final String imageUrl;
  final String title;
  final String artist;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        DecoratedBox(
          decoration: BoxDecoration(
            boxShadow: const [
              BoxShadow(
                color: Colors.black12,
                offset: Offset(2, 4),
              ),
            ],
            borderRadius: BorderRadius.circular(10),
          ),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(10),
            child: CachedNetworkImage(
              //360.0/592.0
              imageUrl: imageUrl,
              height: Get.size.height < 600
                  ? Get.size.height / 3
                  : Get.size.width - 50,
              width: Get.size.width - 50,
              fit: BoxFit.cover,
            ),
          ),
        ),
        const SizedBox(height: 20),
        Marquee(
          textDirection: TextDirection.ltr,
          animationDuration: const Duration(seconds: 2),
          backDuration: const Duration(milliseconds: 2000),
          pauseDuration: const Duration(milliseconds: 2000),
          directionMarguee: DirectionMarguee.oneDirection,
          child: Text(
            title,
            maxLines: 1,
            style: TextStyle(
              color: Colors.white,
              fontSize: Get.size.height < 600 ? 18 : 22,
              fontWeight: FontWeight.bold,
            ),
            textAlign: TextAlign.center,
          ),
        ),
        const SizedBox(height: 8),
        Marquee(
          textDirection: TextDirection.ltr,
          animationDuration: const Duration(seconds: 2),
          backDuration: const Duration(milliseconds: 2000),
          pauseDuration: const Duration(milliseconds: 2000),
          directionMarguee: DirectionMarguee.oneDirection,
          child: Text(
            artist,
            style: TextStyle(
              color: Colors.white,
              fontSize: Get.size.height < 600 ? 16 : 18,
              fontWeight: FontWeight.bold,
            ),
            textAlign: TextAlign.center,
          ),
        ),
      ],
    );
  }
}
