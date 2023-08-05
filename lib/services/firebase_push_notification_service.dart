import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:get/get.dart';
// import 'package:get_storage/get_storage.dart';

class FirebasePushNotificationsService extends GetxService {
  // final GetStorage _box = GetStorage();

  Future<FirebasePushNotificationsService> init() async {
    FirebaseMessaging.instance
        .requestPermission(sound: true, badge: true, alert: true);
    print(await FirebaseMessaging.instance.getToken());
    // if (_box.read("deviceID") == null) {
    //   await setDeviceToken();
    // }
    // await fcmOnLaunchListeners();
    // await fcmOnResumeListeners();

    FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      print('Got a message whilst in the foreground!');
      print('Message data: ${message.data}');

      if (message.notification != null) {
        print('Message also contained a notification: ${message.notification}');
      }
    });
    return this;
  }
  // Future<void> setDeviceToken() async {
  //   String? deviceID = await FirebaseMessaging.instance.getToken();
  //   _box.write(
  //     "deviceID",
  //     deviceID,
  //   );
  //   print(deviceID);
  // }
}
