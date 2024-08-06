import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:kamerat_flutter_app/utils/initialize_user_and_purchase_data.dart';
import 'package:kamerat_flutter_app/utils/firebase_configuration.dart';
import 'package:kamerat_flutter_app/stores/notifications.store.dart';
import 'package:kamerat_flutter_app/utils/route_management.dart';
import 'package:kamerat_flutter_app/utils/constants.dart';
import 'package:kamerat_flutter_app/theme.dart';

void main() async {
  await initializeApp();
  runApp(const MyApp());
}

Future<void> initializeApp() async {
  WidgetsFlutterBinding.ensureInitialized();

  await dotenv.load(fileName: ".env");

  initializeDateFormatting('de_DE');

  try {
    await Future.wait([
      initializeUserAndPurchaseData(),
      NotificationStore().init(),
      initializeFireBase(),
    ]);

    FirebaseMessaging.onBackgroundMessage(handleOnBackgroundMessage);
    FirebaseMessaging messaging = FirebaseMessaging.instance;
    RemoteMessage? initialMessage = await messaging.getInitialMessage();

    if (initialMessage != null) {
      WidgetsBinding.instance.addPostFrameCallback((_) async {
        await Future.delayed(
            const Duration(milliseconds: kTotalSplashDuration + 600));
        handleBackgroundNotification(initialMessage);
      });
    }
  } catch (e) {
    Get.toNamed(kServiceDownRoute);
  }
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: kAppName,
      theme: theme,
      debugShowCheckedModeBanner: false,
      initialRoute: kSplashRoute,
      getPages: RouteManagement.getPage(),
    );
  }
}
