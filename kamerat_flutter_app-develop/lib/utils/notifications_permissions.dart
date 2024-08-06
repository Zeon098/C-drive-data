import 'package:firebase_messaging/firebase_messaging.dart';

Future<bool> requestNotificationPermissions() async {
  final settings = await FirebaseMessaging.instance.requestPermission(
    alert: true,
    announcement: false,
    badge: true,
    carPlay: false,
    criticalAlert: false,
    provisional: false,
    sound: true,
  );

  return settings.authorizationStatus == AuthorizationStatus.authorized;
}
