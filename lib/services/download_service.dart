import 'dart:io';

import 'package:dio/dio.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:path_provider/path_provider.dart' as pathprovider;
import 'package:permission_handler/permission_handler.dart';

import '../common/ui.dart';

class DownloadService extends GetxService {
  late String? _url;
  // RewardedAd? ad;
  RxBool isDownloading = false.obs;
  RxBool isFailedToGetAds = false.obs;
  final GetStorage _box = GetStorage();

  Future<bool> requestStoragePermission() async {
    var status = await Permission.storage.status;
    print(!_box.hasData('mdeia_permission'));
    if (status.isDenied && !_box.hasData('mdeia_permission')) {
      // Request permission from the user
      status = await Permission.storage.request();
      await _box.write("mdeia_permission", true);
    } else if (status.isDenied) {
      await openAppSettings();
      status = await Permission.storage.request();
    }
    return status.isGranted;
  }

  // Future<void> startDownload(List<String?> urls) async {
  //   bool isGranted = await requestStoragePermission();
  //   if (!isGranted) return;
  //   _urls = urls;
  //   isDownloading.value = true;
  //   ad = await RewardedAd.create(
  //     // adUnitId: 'demo-rewarded-yandex',
  //     adUnitId: 'R-M-2453536-1',
  //     onAdFailedToLoad: (error) {
  //       // isFailedToGetAds.value = true;
  //       /* Do something */
  //     },
  //   );
  //   await ad!.load(adRequest: const AdRequest());
  //   await ad!.show();
  //   final reward = await ad!.waitForDismiss();
  //   if (reward != null) {
  //     // Start downloading the first item in the list

  //     await _downloadFile();
  //   }
  // }

  Future<void> startDownload(String url) async {
    bool isGranted = await requestStoragePermission();
    if (!isGranted) return;
    _url = url;
    isDownloading.value = true;
    await _downloadFile();
  }

  Future<void> _downloadFile() async {
    List<String> nameList = _url!.split("/");
    print(nameList);

    try {
      Directory? directory = Directory('/storage/emulated/0/Download');

      if (!await directory.exists()) {
        directory = await pathprovider.getExternalStorageDirectory();
      }
      bool directoryExist = await directory!.exists();
      if (directoryExist) {
        String downloadName = "${directory.path}/${nameList.last}";

        await Dio().download(_url!, downloadName);
      }
    } on DioException {
      Get.showSnackbar(Ui.errorSnackBar(message: "Aýdymy ýükläp bolmady".tr));
    }
    Get.showSnackbar(
        Ui.successSnackBar(message: "Aýdym üstünlikli ýüklenildi".tr));
  }
}
