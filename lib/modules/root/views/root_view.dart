import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:just_audio/just_audio.dart';
import 'package:nb_utils/nb_utils.dart';
import '../../../component/botom_player.dart';
import '../../../routes/app_routes.dart';
import '../../../screen/search_screen.dart';
import '../../../utils/colors.dart';
import '../controllers/root_controller.dart';

class RootView extends GetView<RootController> {
  const RootView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      return Scaffold(
        resizeToAvoidBottomInset: false,
        backgroundColor: mpAppBackGroundColor,
        appBar: AppBar(
          elevation: 0.0,
          backgroundColor: mpAppBackGroundColor,
          title: SizedBox(
            height: 40,
            width: Get.size.width,
            child: searchAlbumTextFiled(context),
          ),
        ),
        body: Stack(
          children: [
            controller.currentPage,
            Align(
              alignment: Alignment.bottomCenter,
              child: StreamBuilder<SequenceState?>(
                stream: controller.audioPlayer.sequenceStateStream,
                builder: (context, snapshot) {
                  final state = snapshot.data;
                  if (state != null && state.sequence.isNotEmpty) {
                    return const BotomPlayer();
                  } else {
                    return const SizedBox();
                  }
                },
              ),
            ),
            // Positioned(
            //   left: 0,
            //   right: 0,
            //   bottom: -1,
            //   child: Column(
            //     children: [

            //     ],
            //   ),
            // ),
          ],
        ),
        bottomNavigationBar: BottomNavigationBar(
          elevation: 8,
          selectedItemColor: mpAppButtonColor,
          unselectedItemColor: Colors.white,
          type: BottomNavigationBarType.fixed,
          backgroundColor: cardBackgroundBlackDark,
          currentIndex: controller.currentIndex.value,
          items: const [
            BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Esasy'),
            BottomNavigationBarItem(
                icon: Icon(Icons.person), label: 'Aýdymçylar'),
            BottomNavigationBarItem(icon: Icon(Icons.search), label: 'Žanrlar'),
            BottomNavigationBarItem(icon: Icon(Icons.album), label: 'Albomlar'),
          ],
          onTap: (index) {
            controller.changePage(index);
          },
        ),
      );
    });
  }
}

Widget searchAlbumTextFiled(BuildContext context) {
  return Container(
    height: 40,
    width: 12,
    alignment: Alignment.centerLeft,
    child: AppTextField(
      // controller: TextEditingController(),
      onTap: () {
        Get.toNamed(Routes.search);
      },
      textStyle: primaryTextStyle(color: Colors.white.withOpacity(0.4)),
      textFieldType: TextFieldType.EMAIL,
      textAlign: TextAlign.start,
      readOnly: true,
      textAlignVertical: TextAlignVertical.center,
      decoration: InputDecoration(
        filled: true,
        prefixIcon: Icon(Icons.search, color: Colors.white.withOpacity(0.2)),
        fillColor: mpSearchBarBackGroundColor,
        hintText: 'Gözle...',
        // contentPadding: const EdgeInsets.only(top: 4),
        border: InputBorder.none,
        focusedBorder: InputBorder.none,
        enabledBorder: InputBorder.none,
        errorBorder: InputBorder.none,
        disabledBorder: InputBorder.none,
        contentPadding: const EdgeInsets.only(bottom: 8),
        hintStyle:
            primaryTextStyle(color: Colors.white.withOpacity(0.4), size: 20),
        // focusedBorder:
        //     OutlineInputBorder(borderRadius: BorderRadius.circular(25.7)),
        // enabledBorder:
        //     UnderlineInputBorder(borderRadius: BorderRadius.circular(25.7)),
      ),
    ),
  );
}
