import 'dart:io';
// import 'package:device_preview/device_preview.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:just_audio_background/just_audio_background.dart';
import 'package:nb_utils/nb_utils.dart';
import 'providers/back_end_provider.dart';
import 'routes/app_pages.dart';
import 'services/firebase_push_notification_service.dart';
import 'services/global_service.dart';
import 'services/ip_service.dart';
import 'utils/app_theme.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  //let'sencrypt
  ByteData data =
      await PlatformAssetBundle().load('assets/ca/lets-encrypt-r3.pem');
  SecurityContext.defaultContext
      .setTrustedCertificatesBytes(data.buffer.asUint8List());
  //end

  await JustAudioBackground.init(
    androidNotificationChannelId: 'com.ryanheise.bg_demo.channel.audio',
    androidNotificationChannelName: 'Audio playback',
    androidNotificationOngoing: true,
  );

  await Firebase.initializeApp();

  await GetStorage.init();
  //me add
  await Get.putAsync(() => GlobalService().init());
  await Get.putAsync(() => IpService().init());
  await Get.putAsync(() => BackEndApiClient().init());

  runApp(const MyApp());
  // runApp(DevicePreview(
  //     // enabled: !kReleaseMode,
  //     builder: (BuildContext context) {
  //   SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
  //   return const MyApp();
  // }));
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      onReady: () async {
        await Get.putAsync(() => FirebasePushNotificationsService().init());
      },
      initialRoute: AppPages.initial,
      getPages: AppPages.routes,
      debugShowCheckedModeBanner: false,
      title: 'tmvibes',
      theme: AppThemeData.darkTheme,
      navigatorKey: navigatorKey,
      scrollBehavior: SBehavior(),
    );
  }
}
