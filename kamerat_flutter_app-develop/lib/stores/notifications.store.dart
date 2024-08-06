import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:get/get.dart';
import 'dart:convert';

class NotificationStore {
  static final NotificationStore _instance = NotificationStore._internal();

  NotificationStore._internal();

  factory NotificationStore() {
    return _instance;
  }

  final RxList<RemoteMessage> _notifications = <RemoteMessage>[].obs;
  final RxInt _unreadNotifications = 0.obs;

  Future<void> init() async {
    final preferences = await SharedPreferences.getInstance();

    final notifications = preferences.getString("Benachrichtigungen");

    if (notifications != null) {
      final List<dynamic> notificationsList = jsonDecode(notifications);
      _notifications.addAll(notificationsList
          .map((notification) => RemoteMessage.fromMap(notification))
          .toList());
      _unreadNotifications.value = _notifications.length;
    }

    ever(_notifications, (notifications) {
      preferences.setString(
          "Benachrichtigungen",
          jsonEncode(notifications
              .map((notification) => notification.toMap())
              .toList()));
    });
  }

  void pushNotification(RemoteMessage notification) {
    if (notifications.length == 15) {
      notifications.removeRange(10, 16);
    }
    _notifications.insert(0, notification);
    _unreadNotifications.value++;
  }

  void readNotification(RemoteMessage notification) {
    _notifications.remove(notification);
    _unreadNotifications.value--;
  }

  void readAllNotifications() {
    _notifications.clear();
    _unreadNotifications.value = 0;
  }

  void incrementUnreadNotifications() {
    _unreadNotifications.value++;
  }

  List<RemoteMessage> get notifications => _notifications;
  int get unreadNotifications => _unreadNotifications.value;
  bool get hasUnreadNotifications => _unreadNotifications.value > 0;
}
