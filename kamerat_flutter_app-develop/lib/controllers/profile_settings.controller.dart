import 'package:url_launcher/url_launcher.dart';
import 'package:get/get.dart';
import 'dart:io';

import 'package:kamerat_flutter_app/services/auth.service.dart';
import 'package:kamerat_flutter_app/stores/purchase.store.dart';
import 'package:kamerat_flutter_app/stores/user.store.dart';
import 'package:kamerat_flutter_app/utils/constants.dart';

class ProfileSettingsController extends GetxController {
  void uploadImage(File pickedImage) async {
    final response =
        await AuthService().uploadProfilePicture(image: pickedImage);

    if (response.redirectRoute.isNotEmpty) {
      await Get.offAllNamed(response.redirectRoute);
      return;
    }

    if (response.code == kSuccessCode) {
      UserStore().updateUser(
        UserStore().user.copyWith(image: response.data['image']),
      );
      Get.snackbar("Erfolg", "Profil erfolgreich aktualisiert");
    } else {
      Get.snackbar("Fehler", "Profil konnte nicht aktualisiert werden");
    }
  }

  void logout() async {
    await UserStore().logout();
    await Get.offAllNamed(kMainRoute);
  }

  void deleteAccount() async {
    final response = await AuthService().deleteAccount();
    if (response.redirectRoute.isNotEmpty) {
      await Get.offAllNamed(response.redirectRoute);
      return;
    }

    if (response.code == kSuccessCode) {
      await UserStore().logout();
      await Get.offAllNamed(kMainRoute);
    } else {
      Get.snackbar("Fehler", "Sie können Ihr Konto nicht löschen");
    }
  }

  final UserStore _userStore = UserStore();
  final PurchaseStore purchaseStore = PurchaseStore();

  bool get isSubsriptionAvailable =>
      purchaseStore.isAvailable.value && purchaseStore.products.isNotEmpty;

  bool get shouldShowCancelSubscription =>
      isSubsriptionAvailable && _userStore.isSubscribed;

  bool get shouldShowBuySubscription =>
      isSubsriptionAvailable && !_userStore.isSubscribed;

  void cancelSubscription() {
    launchUrl(Uri.parse(kIOSSubscriptionUrl));
  }
}
