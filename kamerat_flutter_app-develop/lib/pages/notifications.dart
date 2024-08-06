import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:kamerat_flutter_app/stores/notifications.store.dart';
import 'package:kamerat_flutter_app/components/app_bar.dart';
import 'package:kamerat_flutter_app/utils/constants.dart';

class Notifications extends StatelessWidget {
  const Notifications({super.key});

  @override
  Widget build(BuildContext context) {
    final notificationStore = NotificationStore();

    return Scaffold(
      appBar: const MyAppBar(title: "Benachrichtigungen"),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: ListView.builder(
            itemCount: notificationStore.notifications.length,
            itemBuilder: (context, index) {
              if (notificationStore.notifications[index].notification?.title ==
                      null ||
                  notificationStore.notifications[index].notification?.body ==
                      null) {
                return const SizedBox.shrink();
              }
              return GestureDetector(
                onTap: () {
                  final courseId =
                      notificationStore.notifications[index].data["courseId"];
                  notificationStore
                      .readNotification(notificationStore.notifications[index]);

                  Get.toNamed(
                    kCourseDetailsRoute,
                    arguments: {
                      "courseId": courseId,
                    },
                  );
                },
                child: ListTile(
                  title: Text(notificationStore
                      .notifications[index].notification!.title!),
                  subtitle: Text(notificationStore
                      .notifications[index].notification!.body!),
                ),
              );
            }),
      ),
    );
  }
}
