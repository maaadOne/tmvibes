import 'dart:math';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:nb_utils/nb_utils.dart';
import '../../../models/genre.dart';
import '../../../routes/app_routes.dart';
import '../../../utils/colors.dart';
import '../controller/genres_controller.dart';

class GenresView extends GetView<GenresController> {
  final List<Color> colorList = const [
    Colors.pinkAccent,
    Colors.teal,
    Colors.deepPurple,
    Colors.lightGreen,
    Colors.lime,
    Colors.deepOrange,
    Colors.pink,
    Colors.blueAccent,
    Colors.grey,
    Colors.green,
    Colors.blue,
    Colors.pinkAccent,
    Colors.lightGreen,
    Colors.pink,
    Colors.blueAccent,
    Colors.grey,
    Colors.green,
    Colors.blue,
  ];

  const GenresView({super.key});

  Color getRandomColor() {
    Random random = Random();
    int randomIndex = random.nextInt(colorList.length);
    return colorList[randomIndex];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: mpAppBackGroundColor,
      body: Obx(() {
        return GridView.builder(
          physics: const BouncingScrollPhysics(),
          padding:
              const EdgeInsets.only(left: 16, right: 16, top: 16, bottom: 80),
          shrinkWrap: true,
          itemCount: controller.genres.length,
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              crossAxisSpacing: 20,
              mainAxisSpacing: 20,
              childAspectRatio: 2),
          itemBuilder: (BuildContext context, int index) {
            Genre genre = controller.genres.elementAt(index);
            Color randomColor = getRandomColor();
            return GestureDetector(
              onTap: () {
                Get.toNamed(Routes.genreSongs, arguments: {"genre": genre});
              },
              child: Container(
                color: randomColor,
                child: Text(genre.name!,
                        textAlign: TextAlign.center,
                        style: boldTextStyle(color: Colors.white))
                    .center(),
              ).cornerRadiusWithClipRRect(10),
            );
          },
        );
      }),
    );
  }
}
