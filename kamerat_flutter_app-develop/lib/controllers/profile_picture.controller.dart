import 'package:get/get.dart';
import 'dart:io';

import 'package:kamerat_flutter_app/utils/notifications_permissions.dart';
import 'package:kamerat_flutter_app/stores/purchase.store.dart';
import 'package:kamerat_flutter_app/services/auth.service.dart';
import 'package:kamerat_flutter_app/stores/user.store.dart';
import 'package:kamerat_flutter_app/utils/constants.dart';

class ProfilePictureController extends GetxController {
  Rxn<File> pickedImage = Rxn<File>(null);
  RxBool loading = false.obs;

  void uploadImage() async {
    if (pickedImage.value == null) {
      _navigateToNextScreen();
      return;
    }

    loading.value = true;
    final response =
        await AuthService().uploadProfilePicture(image: pickedImage.value!);

    loading.value = false;

    if (response.redirectRoute.isNotEmpty) {
      await Get.offAllNamed(response.redirectRoute);
      return;
    }
    if (response.code == kSuccessCode) {
      UserStore().updateUser(
        UserStore().user.copyWith(image: response.data['image']),
      );
      _navigateToNextScreen();
    } else {
      Get.snackbar("Fehler", "Profil konnte nicht aktualisiert werden");
    }
  }

  void _navigateToNextScreen() {
    requestNotificationPermissions();
    PurchaseStore().isAvailable.value
        ? Get.offAllNamed(kSubscriptionRoute, arguments: {
            "isForOnBoarding": true,
          })
        : Get.offAllNamed(kMainRoute);
  }
}
