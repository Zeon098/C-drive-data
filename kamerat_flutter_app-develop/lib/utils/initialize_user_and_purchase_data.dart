import 'package:get/get.dart';

import 'package:kamerat_flutter_app/services/in_app_purchase.service.dart';
import 'package:kamerat_flutter_app/stores/purchase.store.dart';
import 'package:kamerat_flutter_app/stores/user.store.dart';
import 'package:kamerat_flutter_app/utils/constants.dart';

Future<void> initializeUserAndPurchaseData() async {
  final userStore = UserStore();
  try {
    await userStore.init();

    if (userStore.isLoggedIn) {
      final response = await InAppPurchaseService().checkSubscriptionStatus();
      if (response.code == kSuccessCode) {
        final subscriptions = response.data['subscription'];
        if (subscriptions.isEmpty) {
          userStore.setIsSubscribed(false);
        } else {
          final subscriptionStatus = subscriptions.any(
            (subscription) =>
                subscription.containsKey('inApppaymentSubscription') &&
                subscription['inApppaymentSubscription'],
          );
          userStore.setIsSubscribed(subscriptionStatus);
        }
      }
    }
    await PurchaseStore().init();
  } catch (e) {
    Get.toNamed(kServiceDownRoute);
  }
}
