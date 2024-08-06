import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:kamerat_flutter_app/services/auth.service.dart';
import 'package:kamerat_flutter_app/utils/constants.dart';

class PasswordChangeController extends GetxController {
  late TextEditingController currentPasswordController;
  late TextEditingController newPasswordController;
  late TextEditingController confirmPasswordController;

  RxBool hideCurrentPassword = true.obs;
  RxBool hideNewPassword = true.obs;
  RxBool hideConfirmPassword = true.obs;

  RxBool processing = false.obs;

  GlobalKey<FormState> formKey = GlobalKey<FormState>();

  @override
  void onInit() {
    currentPasswordController = TextEditingController();
    newPasswordController = TextEditingController();
    confirmPasswordController = TextEditingController();
    super.onInit();
  }

  @override
  void onClose() {
    currentPasswordController.dispose();
    newPasswordController.dispose();
    confirmPasswordController.dispose();
    super.onClose();
  }

  void changePassword() async {
    if (formKey.currentState!.validate()) {
      processing.value = true;
      final response = await AuthService().changePassword(
        currentPassword: currentPasswordController.text,
        newPassword: newPasswordController.text,
      );
      processing.value = false;

      if (response.redirectRoute.isNotEmpty) {
        await Get.offAllNamed(response.redirectRoute);
        return;
      }

      if (response.code == kSuccessCode) {
        Get.back();
        Get.snackbar("Erfolg", "Das Passwort wurde erfolgreich geändert.");
      } else {
        Get.snackbar("Fehler",
            "Das Passwort konnte nicht geändert werden, versuche es erneut.");
      }
    }
  }
}
