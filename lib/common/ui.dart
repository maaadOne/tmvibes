import 'dart:math';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../utils/colors.dart';

class Ui {
  static GetSnackBar successSnackBar(
      {String title = 'Success',
      String? message,
      SnackPosition snackPosition = SnackPosition.BOTTOM}) {
    Get.log("[$title] $message");
    return GetSnackBar(
      titleText: Text(title.tr,
          style: Get.textTheme.titleLarge!
              .merge(const TextStyle(color: iconColorPrimary))),
      messageText: Text(message!,
          style: Get.textTheme.bodySmall!
              .merge(const TextStyle(color: iconColorPrimary))),
      snackPosition: snackPosition,
      margin: const EdgeInsets.all(20),
      backgroundColor: mpTwitterBtnBgColor,
      icon: const Icon(Icons.check_circle_outline,
          size: 32, color: iconColorPrimary),
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 18),
      borderRadius: 8,
      dismissDirection: DismissDirection.horizontal,
      duration: const Duration(seconds: 5),
    );
  }

  static GetSnackBar errorSnackBar(
      {String title = 'Error',
      String? message,
      SnackPosition snackPosition = SnackPosition.BOTTOM}) {
    Get.log("[$title] $message", isError: true);
    return GetSnackBar(
      titleText: Text(title.tr,
          style: Get.textTheme.titleLarge!
              .merge(const TextStyle(color: iconColorPrimary))),
      messageText: Text(message!.substring(0, min(message.length, 200)),
          style: Get.textTheme.bodySmall!
              .merge(const TextStyle(color: iconColorPrimary))),
      snackPosition: snackPosition,
      margin: const EdgeInsets.all(20),
      backgroundColor: Colors.redAccent,
      icon: const Icon(Icons.remove_circle_outline,
          size: 32, color: iconColorPrimary),
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 18),
      borderRadius: 8,
      duration: const Duration(seconds: 5),
    );
  }

  static GetSnackBar defaultSnackBar(
      {String title = 'Alert', String? message}) {
    Get.log("[$title] $message", isError: false);
    return GetSnackBar(
      titleText: Text(title.tr,
          style: Get.textTheme.titleLarge!
              .merge(TextStyle(color: Get.theme.hintColor))),
      messageText: Text(message!,
          style: Get.textTheme.bodySmall!
              .merge(TextStyle(color: Get.theme.focusColor))),
      snackPosition: SnackPosition.BOTTOM,
      margin: const EdgeInsets.all(20),
      backgroundColor: Get.theme.primaryColor,
      borderColor: Get.theme.focusColor.withOpacity(0.1),
      icon: Icon(Icons.warning_amber_rounded,
          size: 32, color: Get.theme.hintColor),
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 18),
      borderRadius: 8,
      duration: const Duration(seconds: 5),
    );
  }

  static GetSnackBar notificationSnackBar(
      {String title = 'Notification',
      String? message,
      OnTap? onTap,
      Widget? mainButton}) {
    Get.log("[$title] $message", isError: false);
    return GetSnackBar(
      onTap: onTap,
      mainButton: mainButton,
      titleText: Text(title.tr,
          style: Get.textTheme.titleLarge!
              .merge(TextStyle(color: Get.theme.hintColor))),
      messageText: Text(message!,
          style: Get.textTheme.bodySmall!
              .merge(TextStyle(color: Get.theme.focusColor))),
      snackPosition: SnackPosition.TOP,
      margin: const EdgeInsets.all(20),
      backgroundColor: Get.theme.primaryColor,
      borderColor: Get.theme.focusColor.withOpacity(0.1),
      icon:
          Icon(Icons.notifications_none, size: 32, color: Get.theme.hintColor),
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 18),
      borderRadius: 8,
      duration: const Duration(seconds: 5),
    );
  }
}
