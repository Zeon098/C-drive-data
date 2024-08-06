import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:kamerat_flutter_app/controllers/profile_settings.controller.dart';
import 'package:kamerat_flutter_app/pages/profile/auth.dart';
import 'package:kamerat_flutter_app/stores/user.store.dart';
import 'package:kamerat_flutter_app/utils/constants.dart';

class Profile extends StatelessWidget {
  const Profile({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      child: UserStore().isLoggedIn ? const ProfileSettings() : const Auth(),
    );
  }
}

class ProfileSettings extends GetView<ProfileSettingsController> {
  const ProfileSettings({super.key});

  @override
  Widget build(BuildContext context) {
    ProfileSettingsController controller = Get.put(ProfileSettingsController());
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 24.0),
      child: ListView(
        children: [
          Text(
            UserStore().name,
            textAlign: TextAlign.center,
            style: Theme.of(context).textTheme.titleLarge!.copyWith(
                  fontWeight: FontWeight.w600,
                  color: Theme.of(context).colorScheme.tertiary,
                ),
          ),
          const SizedBox(height: 4.0),
          Text(
            "Mitglied Seit ${UserStore().memberSince}",
            textAlign: TextAlign.center,
            style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                  fontWeight: FontWeight.w500,
                  color: Theme.of(context).colorScheme.onBackground,
                ),
          ),
          const SizedBox(height: 24.0),
          Text(
            "Einstellungen",
            style: Theme.of(context).textTheme.titleLarge!.copyWith(
                  fontWeight: FontWeight.w600,
                  color: Theme.of(context).colorScheme.tertiary,
                ),
          ),
          const SizedBox(height: 24.0),
          Text(
            "Konto",
            style: Theme.of(context).textTheme.bodySmall!.copyWith(
                  color: Theme.of(context).colorScheme.onBackground,
                ),
          ),
          const SizedBox(height: 8.0),
          Card(
            clipBehavior: Clip.antiAlias,
            elevation: 0,
            color: Theme.of(context).colorScheme.surface,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8.0),
              side: BorderSide(
                color: Theme.of(context).colorScheme.onPrimaryContainer,
                width: 1.0,
              ),
            ),
            child: Theme(
              data: ThemeData(
                listTileTheme: const ListTileThemeData(
                  contentPadding:
                      EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
                  shape: Border(
                    bottom: BorderSide(
                      color: Color.fromRGBO(230, 236, 232, 1),
                      width: 1.0,
                    ),
                  ),
                  titleTextStyle: TextStyle(
                    fontSize: 14,
                    height: 1.43,
                    fontWeight: FontWeight.w500,
                    color: Color.fromRGBO(8, 65, 28, 1),
                  ),
                  iconColor: Color.fromRGBO(8, 65, 28, 1),
                ),
              ),
              child: Column(
                children: [
                  ListTile(
                    title: const Text("Persönliche Angaben"),
                    trailing: const Icon(Icons.arrow_forward_ios, size: 16.0),
                    onTap: () => Get.toNamed(kPersonalSettingsRoute),
                  ),
                  ListTile(
                    title: const Text("Konto Sicherheit"),
                    trailing: const Icon(Icons.arrow_forward_ios, size: 16.0),
                    onTap: () => Get.toNamed(kAccountSecurityRoute),
                  ),
                  Obx(
                    () {
                      if (controller.shouldShowBuySubscription) {
                        return ListTile(
                          title: const Text("Abonnement kaufen"),
                          onTap: () => Get.toNamed(kSubscriptionRoute),
                        );
                      } else if (controller.shouldShowCancelSubscription) {
                        return ListTile(
                          title: const Text("Abonnement kündigen"),
                          onTap: controller.cancelSubscription,
                        );
                      }
                      return ListTile(
                        title:
                            const Text("Abonnement zur Zeit nicht verfügbar"),
                        textColor: Theme.of(context).colorScheme.error,
                      );
                    },
                  ),
                  Obx(() {
                    if (controller.isSubsriptionAvailable) {
                      return ListTile(
                        title: const Text("Abonnement wiederherstellen"),
                        onTap: () {
                          Overlay.of(context)
                              .insert(controller.purchaseStore.modalOverlay!);
                          controller.purchaseStore.restoreSubscription();
                        },
                      );
                    }
                    return const SizedBox.shrink();
                  }),
                  ListTile(
                    title: const Text("Ihr Konto löschen"),
                    textColor: Theme.of(context).colorScheme.error,
                    onTap: () => showDialog(
                      context: context,
                      builder: (context) {
                        return AlertDialog(
                          backgroundColor:
                              Theme.of(context).colorScheme.surface,
                          title: Text(
                            "Konto löschen",
                            style: Theme.of(context)
                                .textTheme
                                .titleMedium!
                                .copyWith(
                                  color: Theme.of(context).colorScheme.tertiary,
                                ),
                          ),
                          content: Text(
                            "Möchten Sie Ihr Konto wirklich löschen?",
                            style: Theme.of(context)
                                .textTheme
                                .bodyMedium!
                                .copyWith(
                                  color:
                                      Theme.of(context).colorScheme.onSurface,
                                ),
                          ),
                          actions: [
                            TextButton(
                              onPressed: () => Get.back(),
                              child: Text(
                                "Abbrechen",
                                style: Theme.of(context)
                                    .textTheme
                                    .bodyMedium!
                                    .copyWith(
                                      color: Theme.of(context)
                                          .colorScheme
                                          .onSurface,
                                    ),
                              ),
                            ),
                            TextButton(
                              onPressed: controller.deleteAccount,
                              child: Text(
                                "Löschen",
                                style: Theme.of(context)
                                    .textTheme
                                    .bodyMedium!
                                    .copyWith(
                                      color:
                                          Theme.of(context).colorScheme.error,
                                    ),
                              ),
                            ),
                          ],
                        );
                      },
                    ),
                  )
                ],
              ),
            ),
          ),
          const SizedBox(height: 16.0),
          TextButton(
            onPressed: controller.logout,
            style: TextButton.styleFrom(
              padding: EdgeInsets.zero,
              minimumSize: Size.zero,
              tapTargetSize: MaterialTapTargetSize.shrinkWrap,
            ),
            child: Text(
              "Ausloggen",
              style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                    fontWeight: FontWeight.w600,
                    color: Theme.of(context).colorScheme.primary,
                  ),
            ),
          ),
        ],
      ),
    );
  }
}
