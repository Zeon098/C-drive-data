import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:kamerat_flutter_app/stores/notifications.store.dart';
import 'package:kamerat_flutter_app/stores/user.store.dart';
import 'package:kamerat_flutter_app/utils/constants.dart';

class HomeBar extends StatelessWidget implements PreferredSizeWidget {
  const HomeBar({super.key});

  @override
  Size get preferredSize => const Size.fromHeight(90);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 24.0, horizontal: 18.0),
      decoration: const BoxDecoration(
        gradient: LinearGradient(colors: [
          Color.fromRGBO(19, 154, 67, 1),
          Color.fromRGBO(20, 166, 47, 1)
        ]),
        borderRadius: BorderRadius.only(
          bottomLeft: Radius.circular(24),
          bottomRight: Radius.circular(24),
        ),
      ),
      child: AppBar(
        backgroundColor: Colors.transparent,
        scrolledUnderElevation: 0,
        leadingWidth: UserStore().isLoggedIn ? 48.0 : 0,
        titleSpacing: 8.0,
        centerTitle: false,
        title: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Text(
            UserStore().isLoggedIn
                ? "Hi! ${UserStore().name} 👋"
                : "Willkommen zurück 👋",
            style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                  fontWeight: FontWeight.w600,
                  color: Theme.of(context).colorScheme.surface,
                ),
          ),
          UserStore().isLoggedIn
              ? Text(
                  "Willkommen zurück",
                  style: Theme.of(context).textTheme.bodySmall!.copyWith(
                        fontWeight: FontWeight.w500,
                        color: Theme.of(context).colorScheme.onPrimaryContainer,
                      ),
                )
              : GestureDetector(
                  onTap: () => Get.toNamed(kSignInRoute),
                  child: Text("Melde Dich bei Deinem Konto an",
                      style: Theme.of(context).textTheme.bodySmall!.copyWith(
                            fontWeight: FontWeight.w500,
                            color: Theme.of(context)
                                .colorScheme
                                .onPrimaryContainer,
                            decoration: TextDecoration.underline,
                            decorationColor: Theme.of(context)
                                .colorScheme
                                .onPrimaryContainer,
                          )),
                ),
        ]),
        actions: [
          if (UserStore().isLoggedIn)
            Stack(
              children: [
                IconButton(
                  onPressed: () => Get.toNamed(kNotificationsRoute),
                  icon: Image.asset("assets/icons/notification.png"),
                  style: IconButton.styleFrom(
                    backgroundColor: Theme.of(context).colorScheme.surface,
                    shape: const CircleBorder(),
                  ),
                ),
                Positioned(
                  top: 2,
                  right: 12,
                  child: Obx(
                    () => NotificationStore().hasUnreadNotifications
                        ? Container(
                            padding: const EdgeInsets.all(3.0),
                            decoration: BoxDecoration(
                              color: Theme.of(context).colorScheme.error,
                              shape: BoxShape.circle,
                            ),
                            child: Text(
                              '${NotificationStore().unreadNotifications}',
                              style: const TextStyle(
                                fontSize: 8.0,
                                fontWeight: FontWeight.w600,
                                height: 1.5,
                                color: Colors.white,
                              ),
                            ),
                          )
                        : const SizedBox.shrink(),
                  ),
                ),
              ],
            ),
        ],
      ),
    );
  }
}
