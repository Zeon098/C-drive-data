import 'package:firebase_messaging/firebase_messaging.dart';
import 'dart:async';

import 'package:kamerat_flutter_app/services/notification.service.dart';
import 'package:kamerat_flutter_app/utils/constants.dart';

const Duration retryDelay = Duration(seconds: 5);
const int maxAttempts = 3;

Future<void> fcmTokenRegistration() async {
  try {
    final token = await FirebaseMessaging.instance.getToken();
    if (token == null) return;

    for (int i = 0; i < maxAttempts; i++) {
      final response =
          await NotificationService().registerFCMToken(token: token);
      if (response.code == kSuccessCode) break;

      if (i < maxAttempts - 1) {
        await Future.delayed(retryDelay);
      }
    }
  } catch (e) {
    // Handle or log the error
  }
}
