import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:get/get.dart';

import 'package:kamerat_flutter_app/stores/notifications.store.dart';
import 'package:kamerat_flutter_app/firebase_options.dart';
import 'package:kamerat_flutter_app/stores/user.store.dart';
import 'package:kamerat_flutter_app/utils/constants.dart';

Future<void> initializeFireBase() async {
  try {
    await Firebase.initializeApp(
        options: DefaultFirebaseOptions.currentPlatform);

    FirebaseMessaging.onMessage.listen(handleForegroundNotification);
    FirebaseMessaging.onMessageOpenedApp.listen(handleBackgroundNotification);
  } catch (e) {
    //error handling
  }
}

void handleForegroundNotification(RemoteMessage notification) {
  if (notification.data["type"] == kSubscriptionNotificationType) {
    handleSubscriptionNotification(notification);
  } else {
    NotificationStore().pushNotification(notification);
  }
}

Future<void> handleOnBackgroundMessage(RemoteMessage notification) {
  if (notification.data["type"] == kSubscriptionNotificationType) {
    handleSubscriptionNotification(notification);
  }
  return Future.value();
}

void handleBackgroundNotification(RemoteMessage notification) {
  if (notification.data["type"] == kCourseNotificationType) {
    handleCourseNotification(notification);
  } else if (notification.data["type"] == kSubscriptionNotificationType) {
    handleSubscriptionNotification(notification);
  }
}

void handleCourseNotification(RemoteMessage notification) {
  Get.toNamed(
    kCourseDetailsRoute,
    arguments: {
      "courseId": notification.data["courseId"],
    },
  );
}

void handleSubscriptionNotification(RemoteMessage notification) {
  UserStore().setIsSubscribed(stringToBool(notification.data["isSubscribed"]));
}

bool stringToBool(String value) {
  return value.toLowerCase() == 'true';
}
